// portail IWQ carte CAME ZBX6N/7N - Version 02 07 2022 11h
// pour ARDUINO NANO - F1IWQ
// si clone de NANO : choisir processeur : ATMEGA 328P Old bootloader
// si vrai NANO     : choisir processeur : ATMEGA 328P
// pour la compilation et le téléchargement, sélectionner arduino NANO sinon le téléchargement ne fonctionnera pas.
// Ne pas utiliser Tempo() dans la fonction traitement() ni dans les fonctions à l'intérieur à savoir recul_lent() et avance_lent() mais delay.
// L'origine 0 de l'encodeur est en position reculée (Fc arrière)=portail ouvert
// *********************************************************
// Compilation pour la carte V1.0 ou V2.0
// en V1 : l'encodeur est traité par l'IRQ matérielle, encod sur pin D8.
// ----------------------------------------------------------------------------------
// en V2 : l'encodeur est traité par l'IRQ matérielle, encod sur pin D3
// ----------------------------------------------------------------------------------
// 1 tour programme principal (main) dure en moyenne 800 à 850µs
//
#define V1   // carte V1.0 ou V2.0
//#define modes_etendus  // modes de pilotage supplémentaires du moteur. Uniquement pour test

#include <TimerOne.h>
#include <EEPROM.h>
// récepteur 433
#include <RCSwitch.h>

// bibliothèque ssd1306ascii allégée pour nano pour écran oled
#include <SSD1306Ascii.h>
#include <SSD1306AsciiAvrI2c.h>
#include <SSD1306AsciiSoftSpi.h>
#include <SSD1306AsciiSpi.h>
#include <SSD1306AsciiWire.h>
#include <SSD1306init.h>

// écran oled
#define I2C_ADDRESS 0x3C
// Sans broche RESET
#define RST_PIN -1

// organisation des lignes de l'écran d'exploitation---------------------
#define ligne_encodeur   3
#define ligne_erreur     7

#define Tempo_sortie_menu 20 // 20 s
// organisation des Y lignes de l'écran MENU (1)
#define premiere_ligneM  1
#define derniere_ligneM  9
#define offset_M         2  // début de l'affichage en Y=2

#define ligne_aprentiss  1  // lancement de l'apprentissage
#define ligne_Param_sens 2  // paramètre F54 : sens d'ouverture du portail
#define ligne_Param_PPS  3  // paramètre F7  : 0=ouverture complète/fermeture complète  1=ouverture/arret/fermeture/arret
#define ligne_eprom      4  // Sauvegarde des paramètres en EPROM
#define ligne_telecom    5  // Gestion des télécommandes
#define ligne_ES         6  // affichage des E/S
#define ligne_tpsmax     7  // temps maxi de fonctionnement
#define ligne_acc        8  // 
#define ligne_dec        9  // 


const String ligne_menu_S[]={"Apprentissage",
                             "Sens d'ouverture=",
                             "Sequencement=",
                             "Sauvegarde EPROM",
                             "Gestion telecommandes",
                             "Affichage entrees",
                             "Tps max fonction=",
                             "Tps accel=",
                             "Tps decel="};

// organisation des lignes de l'écran télécommandes (2)
#define premiere_ligneT  1
#define derniere_ligneT  2
#define Offset_T         3  // début en Y=3

#define ligne_telecomA   1  // Ajouter une télécommande
#define ligne_telecomL   2  // Liste et suppression des télécommandes

// ports d'entrées / sorties----------------------------------------
#define   led       13     // D13 portB.5 led intégrée
#define   BpM       12     // D12 portB.4 Bouton -
#define   BpP       11     // D11 portB.3 Bouton +
#define   Var       10     // D10 portB.2 Variation (commande triac)
#define   BpE        9     // D9  portB.1 Bouton ENTREE
#define   Commande   7     // D7  portD.7 ommande ouverture/fermeture 
#define   FcFerme    6     // D6  portD.6 Fin de course fermé
#define   FcOuvert   5     // D5  portD.5 Fin de course ouvert
#define   Cellule    4     // D4  portD.4 Photo-cellule
#define   data       2     // D2  portD.2 Rx radio 433 MHz

#ifdef    V1               // définitions spécifiques de la carte V1
#define   encod      8     // D8  portB.0 Encodeur 
#define   BpEch      3     // D3  portD.3 Bouton Ech
#endif

#ifdef    V2               // définitions spécifiques de la carte V2
#define   encod      3     // D3  portD.3 Encodeur 
#define   BpEch      8     // D8  portB.0 Bouton Ech
#endif

// port C de l'ATMEGA328 
#define   Scl       A5     // portC.5 SCL
#define   Sda       A4     // portC.4 SDA
#define   R4        A3     // portC.3 bit 3 Relais 4
#define   R3        A2     // portC.2 bit 2 Relais 3
#define   R2        A1     // portC.1 bit 1 Relais 2
#define   Tick      A0     // portC.0 bit 0 tour programme debug oscilloscope
// A6 et A7 uniquement en entrée analogiques - 10 bits valeurs de 0 à 1023.
#define   Onde      6     // A6 numérisation signal secteur 
#define   rien      7     // A7

#define   Nbre_Max_telecom 20  // nombre maxi de télécommandes 

volatile int  erreur,ech,valeur,compsec,Compt10Sec,secondes,nombre,i,compteur_ech,val_secteur[50];
volatile int  Temps_boutonM,Temps_boutonP,val_tempo,ligne_menu,PosRalenti_ferm,PosRalenti_ouv ;
volatile int  Nbre_demi_sinus,angle_retard,Temps_boutonE,AncErreur,Aech,Seq,Temps_boutonEch;
volatile int  Tempo_menu,derniere_ligne,premiere_ligne,PageMenu,cpt_mvt,Seq_mvt,attendre,timer;
volatile int  Nbre_telecom,tempo_affT,Nbit,Protocole,Temps_bornier,Tps_fonctionnement,Tps_fonc_P;
volatile int  decale,offset,Tps_cellule,Tps_ctrl_encod,cpt_mvt_10,AAAech,AAech;
volatile int  PosEncodeur,Anc_Encodeur,vitesse,AncPos,Tps_accP,Tps_acc,Tps_dec,Tps_decP;
volatile byte Sens_Ouv,Sens_Ouv_P,PPS,PPS_P,octet,compt_vit,TpsRalenti_ouv,TpsRalenti_ferm;
volatile bool demande_arret,posOnde,trouveOnde,etatencod,ancetatencod,Fc_ferme,Fc_ouvert,avance,recul ; 
volatile bool Aferme,Aouvert,simu,recul_cours,avance_cours,posOk,MemRecul,MemAvance,memo_lent ;
volatile bool dem_inc_boutonM,dem_inc_boutonP,Cellule_ok,ACellule,menu,Anc_BpP,Anc_BpM,Anc_BpE ;
volatile bool simuMenu,Simu8,Simu2,Enter,m1,m2,m3,m4,m23,Anc_BpEch,Etat_BpP,Etat_BpM,Msg_cell_ok;
volatile bool dem_inc_boutonE,md2,md3,mode_test,Etat_BpE,Etat_BpEch,dem_cpt_mvt,curseur;
volatile bool Fm_M,Fm_E,Fm_P,Fm_Ech,Aff_ES,dem_inc_boutonEch,Fm_O,Fm_F,Fd_O,Fd_F,Dem_Telecom;
volatile bool Dem_Liste_Tel,radio,arrete,Cde_bornier,Fm_Bornier,Abornier,demande_arr_imm;
volatile bool demande_recul_imm,FmBornier,Man_Bornier,Err_enc,m34,mode_temps;
volatile bool Msg_cell_nok,Verrou,Fm_Verrou,AVerrou,Fd_Verrou,msgVerr;
volatile long iteration,Code,telecom[Nbre_Max_telecom];
char          inByte ;
String        s,chaine,vide,chaineEnCours ;

SSD1306AsciiWire oled;
RCSwitch Rx = RCSwitch();

// Interruption matérielle de l'encodeur appellée si changement de front sur 
// l'entrée D8: D8 à D13 en V1
// l'entrée D3 en V2
#ifdef V1
ISR (PCINT0_vect)
#endif
#ifdef V2
void gest_encodeur()
#endif
{
  // Serial.println(digitalRead(encod));
  // intégration encodeur, pris en compte uniquement sur un mouvement moteur ---------
  if (avance_cours | recul_cours) 
  {
    if (avance_cours) ++PosEncodeur;  // avance
    if (recul_cours)  --PosEncodeur;  // recul
  } 
}

// 4608 / $1200 = 1 génère seconde
// 1 interruption timer toutes les 217,01388 micro secondes (0.217 ms) (4608 Hz)
// le signal 100 Hz a une période de 10 ms, soit 10/0,217 = 46 passages dans l'interruption.
void Interrupt_T1() 
{
  // lecture tension secteur
  if (bit_is_clear(ADCSRA,ADSC))  // échantillon prêt ?
  {  
    ++compteur_ech;  // nombre d'échantillons depuis le dernier passage à 0
    AAAech=AAech;
    AAech=Aech;
    Aech=ech;        // ancienne valeur
    ech=ADC;         // lire la valeur analogique de la phase secteur

    // demande de conversion analogique suivante
    ADMUX=(0xf0 & ADMUX) | Onde ;    // A6 au multiplexeur 
    ADCSRA |=(1 << ADSC);            // mise à 1 du bit ADSC du registre ADCSRA (demande de conversion)   
    
    // stocker dans tableau la phase (uniquement pour inspection manuelle)
    if ((compteur_ech<50) & (compteur_ech>=0) & (erreur!=1)) val_secteur[compteur_ech]=ech;
    
    // détection min sinusoide 
    posOnde=(AAAech>AAech) & (Aech<ech) & (ech<250); 
    if (posOnde & !trouveOnde)
    {
      trouveOnde=HIGH;
      if (erreur==1) erreur=0; 
      ++Nbre_demi_sinus;
      compteur_ech=0;
      if (erreur!=1) val_secteur[compteur_ech]=ech;

      // conditions de RAZ du compteur de nombre de demi sinusoïdes en fonction du mode
      if ( (m2  & (Nbre_demi_sinus>=4)) |   // pour les modes m: toujours RAZ sur un nombre pair car on envoie une sinusoïde complète 1x tous les n
           (m3  & (Nbre_demi_sinus>=6)) |
           (m4  & (Nbre_demi_sinus>=8)) |
           (md2 & (Nbre_demi_sinus>=3)) |   // pour les modes md: toujours RAZ sur un nombre impair car on envoie une demi sinusoïde m sur n
           (md3 & (Nbre_demi_sinus>=5)) |
           (m23 & (Nbre_demi_sinus>=6)) |
           (m34 & (Nbre_demi_sinus>=8)) 
         ) 
      Nbre_demi_sinus=0;       
    }

    if (!posOnde) trouveOnde=LOW;

    // erreur si on a pas détecté la phase 0 au bout de 60 échantillons
    if (compteur_ech>60)
    {
      erreur=1; 
      //Serial.println("E");
      compteur_ech=0;
    }
  
    // pilotage de la pin VAR à 1 si pas arrêté
    if ( !arrete & (compteur_ech>=angle_retard) & (compteur_ech<angle_retard+10) & // +10 détermine la largeur du créneau envoyé à la gachette
         ( 
            m1 | 
           (m2 & (Nbre_demi_sinus<2)) | 
           (m3 & (Nbre_demi_sinus<2)) |  
           (m4 & (Nbre_demi_sinus<2)) | 
          (md2 & (Nbre_demi_sinus<1)) | 
          (md3 & (Nbre_demi_sinus<1)) | 
          (m23 & (Nbre_demi_sinus<4)) |
          (m34 & (Nbre_demi_sinus<6))
         )
       )
    {
     digitalWrite(Var,1);
     digitalWrite(led,1);
    }    
    // si on dépasse la consigne, on ne pilote pas la sortie gachette "var"
    else 
    {
      digitalWrite(Var,0);  
      digitalWrite(led,0);
    }
  }

  ++compsec;       // compteur 1 seconde
  ++Compt10Sec;    // compteur 1/10eme de seconde

  // compteurs appui boutons (en temps timer 217µs)
  if (dem_inc_boutonM) ++Temps_boutonM;
  if (dem_inc_boutonP) ++Temps_boutonP;
  if (dem_inc_boutonE) ++Temps_boutonE;
  if (dem_inc_boutonEch) ++Temps_boutonEch;

  // séquenceur 1/10 seconde---------------
  if (Compt10Sec>=460)
  {
    Compt10Sec=0;

    if (dem_cpt_mvt) ++cpt_mvt_10; else cpt_mvt_10=0;  // compteur mvt en 1/10 de s
    // vérification de l'encodeur----------------------
    if (!mode_test & !mode_temps)  // si mode_test=1 ou mode_temps=1, on ne vérifie pas l'encodeur
    {
      if ( (avance_cours | recul_cours) & (cpt_mvt_10>10) ) // contrôle de l'encodeur après 1,0s de mouvement (pour l'accélération)
      {
        --Tps_ctrl_encod;
        if (Tps_ctrl_encod<=0) 
        {
          Tps_ctrl_encod=3;     // vérification toutes les 0,3 seconde   
          if (
               ((abs(PosEncodeur-Anc_Encodeur)<80) & !memo_lent) | // 80=nombre de points codeurs, augmenter la valeur pour augmenter le seuil de détection d'erreur
               ((abs(PosEncodeur-Anc_Encodeur)<20) & memo_lent)  
             )  
          { // erreur pas de changement de l'encodeur pendant un mouvement: peut être obstacle!
            erreur=3;
            Err_enc=HIGH;
            if (avance_cours) demande_recul_imm=HIGH; // sur une avance, on recule sans décélération
            else demande_arr_imm=HIGH;                // sur un recul, on arrete sans décélération
          }   
          else 
          {
            Err_enc=LOW;
            if (erreur==3) {erreur=0;}  
          }
        Anc_Encodeur=PosEncodeur;
        }
      }     
    }  
    
    // vitesse du portail: mesure toutes les 0,3 s
    ++compt_vit;
    if (compt_vit>=3)
    {
      compt_vit=0;     
      vitesse=AncPos-PosEncodeur;
      AncPos=PosEncodeur;
    }  
    
    if (val_tempo!=0) --val_tempo;
  }
  // seconde
  if (compsec>=4608)
  {
    compsec=0;
    ++secondes;
    if (tempo_affT!=0) --tempo_affT;
    if (dem_cpt_mvt) ++cpt_mvt;
    if (Tempo_menu>0) ++Tempo_menu;
  }  

  // les signaux cellule et commande présentent un pic de tension haut toutes les 10ms
  // car ils sont alimentés par un optocoupleur AC (U2A et U2D)
  // filtrage à 60x0,217ms = 13 ms : tempo de recouvrement suffisante
  // filtrage cellule 
  ACellule=Cellule_ok;
  if ((digitalRead(Cellule))==LOW) {Tps_cellule=60;Cellule_ok=HIGH;}
  if (Tps_cellule>0) 
  {
    --Tps_cellule;
    if (Tps_cellule==0) Cellule_ok=LOW;
  }
  if (!ACellule & Cellule_ok) Msg_cell_ok=HIGH;
  if (ACellule & !Cellule_ok) Msg_cell_nok=HIGH;

  // filtrage commande
  Abornier=Cde_bornier;
  if ((digitalRead(Commande))==LOW) {Temps_bornier=60;Cde_bornier=HIGH;}
  if (Temps_bornier>0) 
  {
    --Temps_bornier;
    if (Temps_bornier==0) {Cde_bornier=LOW;}
  }
  Fm_Bornier=!Abornier & Cde_bornier;
  if (Fm_Bornier) Man_Bornier=!menu;
} 

// masque de l'écran de base
void Ecran_base()
{
  oled.setInvertMode(0);
  oled.setFont(System5x7);
  oled.clear();
  oled.set2X();
  oled.println(F("Portail JC")); 
  oled.set1X();
  //oled.setScrollMode(SCROLL_MODE_AUTO);
  oled.setScrollMode(SCROLL_MODE_OFF);
  oled.setCursor(0,ligne_encodeur);oled.println(F("Pos=0"));
}

void ecrit_eprom()
{
  EEPROM.write(0,Sens_Ouv); 
  EEPROM.write(1,PPS); 
  EEPROM.write(2,Nbre_telecom);
  EEPROM.write(3,Tps_fonctionnement);
  //PosRalenti_ouv=0+1000;
  //PosRalenti_ferm=16400-1000;
  EEPROM.write(4,PosRalenti_ferm >> 8);    // 2 octets
  EEPROM.write(5,PosRalenti_ferm & 0xFF);   
  
  EEPROM.write(6,PosRalenti_ouv >> 8);     // 2 octets
  EEPROM.write(7,PosRalenti_ouv & 0xFF);  
  EEPROM.write(8,Tps_acc);
  EEPROM.write(9,Tps_dec);
     
  // les codes des télécommandes sont stockées sur 4 octets (long) à partir de l'adresse 10
  for (i=0 ; i<Nbre_telecom ; i++)
  {
    octet=telecom[i] & 0xFF;
    EEPROM.write((i*4)+10,octet);   
    octet=(telecom[i]>>8) & 0xFF;
    EEPROM.write((i*4)+11,octet);   
    octet=(telecom[i]>>16) & 0xFF;
    EEPROM.write((i*4)+12,octet);  
    octet=(telecom[i]>>24) & 0xFF;
    EEPROM.write((i*4)+13,octet); 
  }
}

void lit_eprom()
{
   long L3,L4,L2,L1;
   Sens_Ouv=EEPROM.read(0);           // sens de l'ouverture
   PPS=EEPROM.read(1);                // mode de fonctionnement : Avance / Arret / Recul  (sinon Avance / Recul)
   Nbre_telecom=EEPROM.read(2);       // Nombre de télécommandes mémorisées
   Tps_fonctionnement=EEPROM.read(3); // temps maximal de fonctionnement
   PosRalenti_ferm=EEPROM.read(4)*256+EEPROM.read(5);    // paramètre sur 2 octets (int)
   PosRalenti_ouv=EEPROM.read(6)*256+EEPROM.read(7);     // paramètre sur 2 octets (int)
   Tps_acc=EEPROM.read(8);           
   Tps_dec=EEPROM.read(9);
   
   if (Nbre_telecom>Nbre_Max_telecom) Nbre_telecom=0;
   if ((Sens_Ouv>1) | (Sens_Ouv<0)) Sens_Ouv=1;
   if ((PPS>1) | (PPS<0)) PPS=1;
   if ((Tps_fonctionnement>99) | (Tps_fonctionnement<1)) Tps_fonctionnement=99;
   if ((PosRalenti_ouv>32000) | (PosRalenti_ouv<1)) PosRalenti_ouv=1000;
   if ((PosRalenti_ferm>32000) | (PosRalenti_ferm<1)) PosRalenti_ferm=32000;
   if ((Tps_acc>30) | (Tps_acc<2)) Tps_acc=10;
   if ((Tps_dec>30) | (Tps_dec<2)) Tps_dec=10;
     
   // les codes des télécommandes sont stockées en @10 eeprom
   // on peut stocker (1024-10)/4 = 253 télécommandes
   for (i=0 ; i<Nbre_telecom ; i++)
   {
     L1=EEPROM.read((i*4)+10);
     L2=EEPROM.read((i*4)+11);
     L3=EEPROM.read((i*4)+12);
     L4=EEPROM.read((i*4)+13);
     telecom[i]=L1 + ((L2<<8) & 0xFFFF) + ((L3<<16) & 0xFFFFFF) + ((L4<<24) & 0xFFFFFFFF);
     Serial.print(F("Code telecommande "));Serial.print(i);Serial.print("=");Serial.println(telecom[i]);
   }
    
   Serial.print(F("Sens ouverture [F54]="));Serial.println(Sens_Ouv);
   Serial.print(F("Sequentiel=    [F7] ="));Serial.println(PPS);
   Serial.print(F("Tps fonctionnement maxi="));Serial.println(Tps_fonctionnement); 
   Serial.print(F("PosRalFerm="));Serial.println(PosRalenti_ferm);
   Serial.print(F("PosRalOuv="));Serial.println(PosRalenti_ouv);
   Serial.print(F("Tps acc="));Serial.println(Tps_acc);
   Serial.print(F("Tps dec="));Serial.println(Tps_dec);
}

//-------------------------------------------------- I N I T I A L I S A T I O N S -------------------------------------------------
void setup() 
{
  // Initialisations de la liaison série USB
  Serial.begin(115200);  // USB

  // ports d'entrées et de sorties
  pinMode(R2,OUTPUT); digitalWrite(R2,LOW);
  pinMode(R3,OUTPUT); digitalWrite(R3,LOW);
  pinMode(R4,OUTPUT); digitalWrite(R4,LOW);
  pinMode(Var,OUTPUT);digitalWrite(Var,LOW);
  pinMode(led,OUTPUT);
  pinMode(Tick,OUTPUT);

  pinMode(Commande,INPUT);
  pinMode(FcFerme,INPUT);
  pinMode(FcOuvert,INPUT);
  pinMode(Cellule,INPUT);
  pinMode(encod,INPUT);
  pinMode(BpP,INPUT);
  pinMode(BpM,INPUT);
  pinMode(BpE,INPUT);
  pinMode(BpEch,INPUT);
  pinMode(data,INPUT);
  
  Serial.println(F("Programme portail JC - F1IWQ 2022\r\nTapez ? pour l'aide"));

  // initialisation de la conversion analogique
  // nota: on ne peut pas utiliser analogRead qui dure 100µS ce qui est beaucoup trop long.
  // On utlise donc les convertiseurs de façon asynchrone. (demande de conv et lecture de la valeur plus tard)
  ADMUX |= (1 << REFS0);  // référence de tension interne
  ADCSRA |= (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); // prédivision à 128
  ADCSRA |= (1 << ADEN);  //valide le convertisseur
  
  // Raz des télécommandes
  for (i=0 ; i<Nbre_Max_telecom ; i++) telecom[i]=0;
     
  // lecture de la configuration et des télécommandes mémorisées
  lit_eprom();
  
  // I2C pour oled
  Wire.begin();
  Wire.setClock(400000L);
 
  // oled sans reset ------------------------------
  #if RST_PIN >= 0
   oled.begin(&Adafruit128x64,I2C_ADDRESS,RST_PIN);
  #else // RST_PIN >= 0
    oled.begin(&Adafruit128x64,I2C_ADDRESS);
  #endif // RST_PIN >= 0
  
  Ecran_base();
  
  // rx 433 MHz -------------------------
  Rx.enableReceive(digitalPinToInterrupt(data));  // On reçoit la télécommande sur INT0 (data=pin D2)
  
  // IRQ encodeur --------------------------------
  #ifdef V1
  //en V1 association de l'IRQ sur portB.D8=encodeur
  PCICR|=0x01;  // changement du portB
  PCMSK0|=0x01; // portB.0
  PCIFR|=0x01;  // PCIF0
  //attachInterrupt(PCINT0,gest_encodeur,CHANGE);  // ne marche pas, irq toujours validée
  #endif
  
  #ifdef V2
  //en V2 association de l'IRQ INT1 sur portB.D3=encodeur
  attachInterrupt(digitalPinToInterrupt(encod),gest_encodeur,CHANGE);
  #endif
  
  // Initialisation des variables
  chaine="";
  chaineEnCours="";
  compteur_ech=0;   // valeur courante du compteur d'échantillons
  PosEncodeur=0;    // position de l'encodeur
  angle_retard=0;   // décalage entre 0 secteur et impulsion gâchette - permet de moduler le couple moteur
  erreur=0;
  AncErreur=0;
  
  menu=LOW;         // pas mode menu
  demande_recul_imm=LOW;
  demande_arr_imm=LOW;
  arrete=HIGH;
  Cellule_ok=HIGH;  // provoque le message cellule coupée au démarrage si la cellule est coupée
  Tps_cellule=1;    // "
  mode_test=LOW;    // permet d'utiliser GV même si position inconnue ou encodeur muet ; attention aux chocs en fin de parcours!!!
  mode_temps=LOW;   // le mode temps utilise un comptage temporel plutot que l'encodeur pour les commutations GV/PV
  posOk=mode_test;  // position connue encodeur
  mode2();          // vitesse mode 1=PV
  vide=F("                     ");

  // initialisation interruption Timer 1
  timer=217;
  Timer1.initialize(timer);  // interruption timer 1 toutes les 217,01388 micro secondes (0.217 ms) (4608 Hz)
  Timer1.attachInterrupt(Interrupt_T1);

  if (mode_test) Serial.println(F("**mode test validé**"));
  /*
  Nbre_telecom=9;
  telecom[1]=22;
  telecom[2]=33;
  telecom[3]=444;
  telecom[4]=555;
  telecom[5]=66;
  telecom[6]=7;
  telecom[7]=8;  
  telecom[8]=9;
  */
  //PosRalenti_ferm=14000;
}


// traitement de fond à effectuer à chaque itération-----------------------
void traitement()
{
  bool trouve;

  // mode test &&&&&&&&&&&&&----
  /*
  if (mode_test)
  {
    if (avance_cours) ++PosEncodeur;  // avance
    if (recul_cours)  --PosEncodeur;  // recul
  } 
  */ 
  // ---------------------------
 
  // lecture des fins de course et des autres entrées
  // Etats précédents (n-1)
  Aferme=Fc_ferme;
  Aouvert=Fc_ouvert;
  AVerrou=Verrou;
 
  Anc_BpP=Etat_BpP;
  Anc_BpM=Etat_BpM;
  Anc_BpE=Etat_BpE;
  Anc_BpEch=Etat_BpEch; 
  
  // Etats actuels (n)
  Etat_BpP=Etat_BoutonP();
  Etat_BpM=Etat_BoutonM();
  Etat_BpE=Etat_BoutonE();
  Etat_BpEch=Etat_BoutonEch();
  Fc_ferme=digitalRead(FcFerme);   // LOW=Fdc libéré HIGH=Fdc enfoncé
  Fc_ouvert=digitalRead(FcOuvert); // idem 
  Verrou=Fc_ferme & Fc_ouvert;
  
  // Fronts montants !(n-1) & (n)
  Fm_P=!Anc_BpP & Etat_BpP;
  Fm_M=!Anc_BpM & Etat_BpM;
  Fm_E=!Anc_BpE & Etat_BpE;
  Fm_Ech=!Anc_BpEch & Etat_BpEch;
  Fm_Verrou=!AVerrou & Verrou;
  
  // fronts montants des Fdc (acostage)
  Fm_F=!Aferme & Fc_ferme;
  Fm_O=!Aouvert & Fc_ouvert;
  
  // Fronts descendants des Fdc (on les quitte)
  Fd_F=Aferme & !Fc_ferme;
  Fd_O=Aouvert & !Fc_ouvert;
  Fd_Verrou=AVerrou & !Verrou;

  // vérification temps de mvt
  if (cpt_mvt>Tps_fonctionnement) 
  {
    Serial.println(F("Arret par tps>fonctionnement long"));
    arret();
    erreur=2;
  }

  // recul immédiat
  if (demande_recul_imm)
  {
    demande_recul_imm=LOW;
    s=F("Recul immediat ");
    Serial.println(s); 
    oled.setCursor(0,2);oled.print(s);
    arret();
    recul_lent();  
  }
  
  // arret immédiat (sans décélération)
  if (demande_arr_imm) 
  {
    demande_arr_imm=LOW;
    s=F("Arret immediat ");
    Serial.println(s); 
    oled.setCursor(0,2);oled.print(s);
    arret();
  }

  if ( (Fd_F & recul_cours)  | (Fd_O & avance_cours) ) Seq_mvt=0; // début de la séquence d'un mouvement complet de Fc à Fc pour le comptage temps maxi

  // affichage position codeur et temps de fonctionnement 
  if (avance_cours | recul_cours)
  {
    if ((iteration % 200)==0)  // Affichage tous les 200 tours
    {
      oled.setCursor(24,ligne_encodeur);oled.print(PosEncodeur);oled.print(" ");
      oled.print(cpt_mvt);oled.print("s V=");
      oled.print(vitesse);oled.print(" ");
      
    }  
  }

  // avance en cours (fermeture) ----------------------------------------------
  if (avance_cours==HIGH)
  {
    if (erreur==2) erreur=0;
    
    // front montant Fc avancé
    if ((!Aferme) & (Fc_ferme) & (posOk)) 
    {
      PosRalenti_ferm=PosEncodeur-1000L;   // fixation de la position de passage GV->PV vers fermeture
    }  
    
    // Fin de course fermé ou cellule coupée arreter le mouvement d'avance
    if ((Fc_ferme) | (!Cellule_ok)) 
    {
      if (Fc_ferme) ++Seq_mvt;  // compteur de séquencement
      arret();
    }
   
    // passer en pv
    if (
         (posOk & (PosEncodeur>PosRalenti_ferm) & !memo_lent & !mode_temps) |  // mode encodeur
         (mode_temps & (cpt_mvt>15) & !memo_lent)  // à ajuster manuellement   // mode temporel
       )  
    {
      Serial.println(F("Position lente vers avance atteinte"));
      avance_lente();
    }
  }  
      
  // recul en cours (ouverture) -----------------------------------------------
  if (recul_cours==HIGH)
  {
    if (erreur==2) erreur=0;

    // front montant Fc reculé
    if ((!Aouvert) & (Fc_ouvert)) 
    {
      posOk=!Err_enc;                     // la position de l'encodeur est ok s'il n'est pas muet
      PosEncodeur=0;                      // RAZ de la position encodeur car front montant origine atteinte
      PosRalenti_ouv=PosEncodeur+1000L;   // fixation de la position de passage GV->PV vers ouverture
    }  
     
    // Fin de course ouvert arreter le mouvement de recul (on ne tient pas compte de la cellule en recul)
    if (Fc_ouvert)  
    {
       if (Fc_ouvert) ++Seq_mvt;  // compteur de séquencement
       arret();
    }
    
    // passer en PV
    if ( 
         (posOk & (PosEncodeur<PosRalenti_ouv) & !memo_lent & !mode_temps) |
         (mode_temps & (cpt_mvt>15) & !memo_lent)  // à ajuster manuellement
       ) 
    {
      Serial.println(F("Position lente vers recul atteinte"));
      recul_lent();
    }   
  }

  // récepteur radio ----------------------------------------------------
  if (Rx.available()) 
  {
    if ((tempo_affT<9) )  // radio filtrée 1 seconde
    {
      Serial.print(F("Recu de RX: "));
      Code=Rx.getReceivedValue();
      Serial.print(Code);
      Serial.print(F(" / "));
      Nbit=Rx.getReceivedBitlength();
      Serial.print(Nbit);
      Serial.print(F("bit "));
      Protocole=Rx.getReceivedProtocol();
      Serial.print(F("Protocole: "));
      Serial.print(Protocole);
 
      if (!menu)
      {
        oled.setCursor(0,6);oled.print(Code);
        oled.print(F(" "));
        oled.print(Nbit);oled.print(F("b "));
        oled.print(F("Pr "));oled.print(Protocole);
        tempo_affT=10;  // temps d'affichage 9s qui va se décrémenter
        // vérifier si télécommande enregistrée
        i=-1;
        trouve=LOW;
        while (!trouve & (i<Nbre_telecom))
        {
          ++i;
          trouve=telecom[i]==Code;
        }
        
        if (trouve) 
        {
          s=F(" OK");
          oled.print(s);
          Serial.println(s);
          radio=!menu;  // envoyer l'ordre de manoeuvre sauf si on est en mode menu
        } 
        else Serial.println(); 
      }    
    } 
    Rx.resetAvailable();
  }  
  // effacement du message de la télécommande
  if ((tempo_affT==1) & !menu) {oled.setCursor(0,6);oled.print(vide);}
}

// tempo en 1/10 de secondes
void tempo(int valeur)
{
  val_tempo=valeur;
  do
    traitement();
  while (val_tempo!=0);
}

// sélection des modes de fonctionnement au triac
// mode 1 = envoi de la sinusoide complète: on arme la gachette à chaque retour à 0 de la sinusoide secteur
// la vitesse est de 100%
void mode1()
{
  m1=HIGH;
  m2=LOW;
  m3=LOW;
  m4=LOW;
  md2=LOW;
  md3=LOW;
  m23=LOW;
  m34=LOW;
}

// mode 2 : envoi de la sinusoide une fois sur 2 : on arme la gachette 2 fois consécutifs sur 4 à chaque retour à 0 de la sinusoide secteur 
// la vitesse est de 50%
void mode2()
{
  m1=LOW;
  m2=HIGH;
  m3=LOW;
  m4=LOW;
  md2=LOW;
  md3=LOW;
  m23=LOW;
  m34=LOW;
}

#ifdef modes_etendus
// mode 3 : envoi de la sinusoide une fois sur 3 : on arme la gachette 2 fois consécutifs sur 6 à chaque retour à 0 de la sinusoide secteur 
// la vitesse est de 30%
void mode3()
{
  m1=LOW;
  m2=LOW;
  m3=HIGH;
  m4=LOW;
  md2=LOW;
  md3=LOW;
  m23=LOW;
  m34=LOW;
}

// mode demi 2 : envoi d'une demi-sinusoide positive et négative espacées de 2 demi-cycles. 
// la vitesse est de 33%
void moded2()
{
  m1=LOW;
  m2=LOW;
  m3=LOW;
  m4=LOW;
  md2=HIGH;
  md3=LOW;
  m23=LOW;
  m34=LOW;
}

// mode demi 3 : envoi d'une demi-sinusoide positive et négative espacées de 4 demi-cycles. 
// la vitesse est de 25%
void moded3()
{
  m1=LOW;
  m2=LOW;
  m3=LOW;
  m4=LOW;
  md2=LOW;
  md3=HIGH;
  m23=LOW;
  m34=LOW;
}

// mode 2/3 (2 sinusoides sur 3)
// la vitesse est de 66%
void mode_23()
{
  m1=LOW;
  m2=LOW;
  m3=LOW;
  m4=LOW;
  md2=LOW;
  md3=LOW;
  m23=HIGH;
  m34=LOW;
}

// mode 3/4 (3 sinusoides sur 4)
// la vitesse est de 75%
void mode_34()
{
  m1=LOW;
  m2=LOW;
  m3=LOW;
  m4=LOW;
  md2=LOW;
  md3=LOW;
  m23=LOW;
  m34=HIGH;
}
#endif

void avance_rapide()
{
  if (Cellule_ok)
  {
    if (Fc_ferme==LOW) 
    {
      if (!avance_cours & !recul_cours)
      {
        Serial.println(F("Accélération avance"));
        avance_lente();  // accélération
        if (!avance_cours)
        {
          i=0;
          do
          {
            ++i;
            delay(100);
          }
          while ((!Fc_ferme) and (i<Tps_acc)) ;  // sort si Fc_ferme=HIGH ou i>=Tps_act
        }
      }
      
      if (recul_cours)   // inversion
      {
        recul_lent();
        i=0;
        do
        {
          ++i; 
          delay(100);
        }
        while ((!Fc_ouvert) and (i<Tps_dec)) ;  // sort si Fc_recul=HIGH ou i>=Tps_dec 
        arret();
      }

      if ((posOk | mode_temps) & !Fc_ferme)  // si position connue encodeur ou mode temps, on avance en rapide
      {
        s=F("Avance rapide   ");
        oled.setCursor(0,2);oled.println(s);
        Serial.println(s);
        mode1();                // vitesse rapide
        angle_retard=0;
        digitalWrite(R2,HIGH);  // R2 à 1 (N sur W et éclairage)
        if (Sens_Ouv==1)
        { 
          digitalWrite(R3,HIGH);  // R3 à 1 (CT sur V)
          digitalWrite(R4,LOW);   // R4 à 0 (rien sur U)
        }
        else
        {
          digitalWrite(R3,LOW);   // R3 à 0 (rien sur V)
          digitalWrite(R4,HIGH);  // R4 à 1 (CT sur U)
        }  
        recul=LOW;
        avance_cours=HIGH;
        recul_cours=LOW;
        memo_lent=LOW;
        arrete=LOW;
        dem_cpt_mvt=HIGH;
      }
      else avance_lente();  // si position inconnue encodeur, on avance en lent    
    }  
  }  
}

void recul_rapide()
{
  if (Fc_ouvert==LOW)  // en recul on ne tient pas compte de la cellule
  {
    if ((!recul_cours) & (!avance_cours))
    {
      Serial.println(F("Accélération recul"));
      recul_lent();    // accélération
      i=0;
      do
      {
        ++i;
        delay(100);
      }
      while ((!Fc_ouvert) and (i<Tps_acc)) ;  // sort si Fc_ouvert=HIGH ou i>=Tps_act
    }
    
    if (avance_cours)  // inversion
    {
      avance_lente();  // réduire la vitesse
      i=0;
      do
      {
        ++i; 
        delay(100);
      }
      while ((!Fc_ouvert) and (i<Tps_dec)) ;  // sort si Fc_ouvert=HIGH ou i>=Tps_dec    
      arret();         // et arrêt pour inverser le sens 
    }

    if ((posOk | mode_temps) & !Fc_ouvert)  // si position connue encodeur ou mode temps, on recule en rapide
    {
      s=F("Recul rapide    ");
      oled.setCursor(0,2);oled.println(s);
      Serial.println(s);
      mode1();                // vitesse rapide
      angle_retard=0;
      digitalWrite(R2,HIGH);  // R2 à 1 (N sur W et éclairage)
      if (Sens_Ouv==1)
      {
        digitalWrite(R3,LOW);   // R3 à 0 (rien sur V)
        digitalWrite(R4,HIGH);  // R4 à 1 (CT sur U)
      }
      else
      {
        digitalWrite(R3,HIGH);  // R3 à 1 (CT sur V)
        digitalWrite(R4,LOW);   // R4 à 0 (rien sur U)
      }  
      recul=HIGH;             // mémorisation on recule
      avance=LOW;
      avance_cours=LOW;
      recul_cours=HIGH;
      memo_lent=LOW;
      arrete=LOW;
      dem_cpt_mvt=HIGH;
    }
    else recul_lent();  // si position inconnue encodeur, on recule en lent    
  }  
}

void avance_lente()
{
  if (Cellule_ok)
  {
    if (Fc_ferme==LOW)
    {
      if (recul_cours)
      {
        recul_lent();
        delay(Tps_dec*100);  
        arret();
      }
      s=F("Avance lente    ");
      oled.setCursor(0,2);oled.println(s);
      Serial.println(s);
     
    // if (!memo_lent & avance_cours)
    // {
    //    // on vient de GV vers PV: passer en mode 2/3
    //    mode_23();  // mode_34();
    //    delay(700);
    //  }
     
      mode2();                // vitesse lente
      //angle_retard=20;
      digitalWrite(R2,HIGH);  // R2 à 1 (N sur W et éclairage)
      delay(200);               // évite de coller 2 relais simultanément 
      if (Sens_Ouv==1)
      {
        digitalWrite(R3,HIGH);  // R3 à 1 (CT sur V)
        digitalWrite(R4,LOW);   // R4 à 0 (rien sur U)
      }
      else
      {
        digitalWrite(R3,LOW);   // R3 à 0 (rien sur V)
        digitalWrite(R4,HIGH);  // R4 à 0 (CT sur U)  
      }
      avance=HIGH;              // mémorisation on avance
      recul=LOW;  
      avance_cours=HIGH;
      recul_cours=LOW;
      memo_lent=HIGH;
      arrete=LOW;
      dem_cpt_mvt=HIGH;
    }  
  }  
}

void recul_lent()
{
  if (Fc_ouvert==LOW)  // en recul on ne tient pas compte de la cellule
  {
    if (avance_cours) 
    {
      avance_lente();
      delay(Tps_dec*100);
      arret();
    }
    s=F("Recul lent   ");
    oled.setCursor(0,2);oled.println(s);
    Serial.println(s);
 
    //if (!memo_lent & recul_cours)
   // {
   //   // on vient de GV vers PV: passer en mode 2/3
   //   mode_23();   //mode_34();
   //   delay(700);
   // }

    mode2();                   // vitesse lente
    //angle_retard=20;
    digitalWrite(R2,HIGH);     // R2 à 1 (N sur W et éclairage)
    delay(200);                // évite de coller 2 relais simultanément 
    if (Sens_Ouv==1)
    {
      digitalWrite(R3,LOW);    // R3 à 0 (rien sur V)
      digitalWrite(R4,HIGH);   // R4 à 1 (CT sur U)
    }
    else
    {
      digitalWrite(R3,HIGH);  // R3 à 1 (CT sur V)
      digitalWrite(R4,LOW);   // R4 à 0 (rien sur U)
    }  
    recul=HIGH;               // mémorisation on recule
    avance=LOW;
    avance_cours=LOW;
    recul_cours=HIGH;
    memo_lent=HIGH;
    arrete=LOW;
    dem_cpt_mvt=HIGH;
  }  
}

void arret()
{
  oled.setCursor(0,2); s=F("Arret          ");oled.println(s);
  oled.setCursor(0,5);oled.println(vide);
  Serial.println(s);  
  digitalWrite(R2,LOW);   // R2 à 0 (rien sur W ni éclairage)
  digitalWrite(R3,LOW);   // R3 à 0 (rien sur V)
  digitalWrite(R4,LOW);   // R4 à 0 (rien sur U)
  demande_arret=LOW;      // raz flag demande arret
  memo_lent=LOW;          // raz flag passage en lent
  avance_cours=LOW;
  recul_cours=LOW;
  dem_cpt_mvt=LOW;
  arrete=HIGH;
  cpt_mvt=0;
  cpt_mvt_10=0;
}

// renvoie HIGH si le bouton + est à 1 depuis 0,2 seconde
bool Etat_BoutonP()
{
  dem_inc_boutonP=!digitalRead(BpP);  // si bouton=0, incrémenter la tempo d'appui dans timer
  if (!dem_inc_boutonP) Temps_boutonP=0;
  if (Temps_boutonP>500) Tempo_menu=1;  // réarmement de la temporisation de sortie du mode menu
  return (Temps_boutonP>500) ;          // si tempo d'appui>0,2 s ok
}

bool Etat_BoutonM()
{
  dem_inc_boutonM=!digitalRead(BpM);  // si bouton=0, incrémenter la tempo d'appui
  if (!dem_inc_boutonM) Temps_boutonM=0;
  if (Temps_boutonM>500) Tempo_menu=1;
  return (Temps_boutonM>500) ;            // si tempo d'appui>0,2 s ok
}

bool Etat_BoutonE()
{
  dem_inc_boutonE=!digitalRead(BpE);  // si bouton=0, incrémenter la tempo d'appui dans timer
  if (!dem_inc_boutonE) Temps_boutonE=0;
  if (Temps_boutonE>500) Tempo_menu=1;
  return (Temps_boutonE>500) ;            // si tempo d'appui>0,2 s ok
}

bool Etat_BoutonEch()
{
  dem_inc_boutonEch=!digitalRead(BpEch);  // si bouton=0, incrémenter la tempo d'appui
  if (!dem_inc_boutonEch) Temps_boutonEch=0;
  if (Temps_boutonEch>500) Tempo_menu=1;
  return (Temps_boutonEch>500) ;            // si tempo d'appui>0,2 s ok
}

// fond de la page menu, page à déroulement pour afficher les paramètres
void fond_menu()
{
  // afficher 6 lignes du menu avec la valeur des parammètres
  for (i=0 ; i<6 ; i++)
  {
    oled.setCursor(6,i+offset);oled.print(ligne_menu_S[i+decale]+vide);
    // paramètres
    if (i+decale+1==ligne_Param_sens) {oled.setCursor(108,i+offset);oled.print(Sens_Ouv);}
    if (i+decale+1==ligne_Param_PPS)  {oled.setCursor(84,i+offset);oled.print(PPS);}
    if (i+decale+1==ligne_tpsmax)     {oled.setCursor(108,i+offset);oled.print(Tps_fonctionnement);}
    if (i+decale+1==ligne_acc)        {oled.setCursor(66,i+offset);oled.print(Tps_acc);}
    if (i+decale+1==ligne_dec)        {oled.setCursor(66,i+offset);oled.print(Tps_dec);}
  }    
}

// écran de fond menu télécommandes
void fond_telecom()
{
  if (Nbre_telecom>0)
  {
    i=0;
    do
    {
      oled.setCursor(6,i+offset);oled.print(i+1+decale);oled.print(" ");oled.print(telecom[i+decale]+vide);
      ++i;
    }
    while ((i<Nbre_telecom) & (i+offset<=7));  //sortir si i>=Nbre telecom ou i+offset>7
  }  
}

int coordY()
{
  return (ligne_menu+offset-decale-1);
}

// ------------------------------------------------ P R O G R A M M E   P R I N C I P A L --------------------------------------------
void loop() 
{
  //digitalWrite(Tick,HIGH);
  ++iteration;
  if (iteration>32000) iteration=0;
      
  traitement();    // traitement de fond
  //digitalWrite(Tick,LOW);
  
  if (!menu)
  { 
    // affichage erreur
    if ((AncErreur==0) & (erreur==1))
    { 
      AncErreur=erreur;
      s=F("Secteur non trouve  ");
      Serial.println(s);
      oled.setCursor(0,ligne_erreur);oled.print(s);
    }

    if ((AncErreur==1) & (erreur==0))
    { 
      AncErreur=erreur;
      s=F("Secteur trouve     ");
      Serial.println(s);
      oled.setCursor(0,ligne_erreur);oled.print(s);
    }

    if ((AncErreur==0) & (erreur==2))
    { 
      AncErreur=erreur;
      s=F("Erreur mvt trop long");
      oled.setCursor(0,ligne_erreur);oled.print(s);
      Serial.println(s);
    }  

    if ((AncErreur!=0) & (erreur==0))
    { 
      AncErreur=erreur;
      oled.setCursor(0,ligne_erreur);oled.print(vide);
    }
    
    if ((AncErreur==0) & (erreur==3))
    { 
      AncErreur=erreur;
      s=F("Encodeur muet       ");
      oled.setCursor(0,ligne_erreur);oled.print(s);
      Serial.println(s);
    }  

    // Affichage Evt Fdc et cellule ----------------------------------------------------------
    if (Fm_F)
    {
      s=F("Fdc ferme ");
      Serial.println(s);
      oled.setCursor(0,4);oled.println(s);
    }
    if (Fd_F)
    {
      Serial.println(F("Fdc ferme libéré"));
      oled.setCursor(0,4);oled.println(vide);
    }
    
    if (Fm_O)
    {
      s=F("Fdc ouvert");
      Serial.println(s);
      oled.setCursor(0,4);oled.println(s);
    }
    if (Fd_O)
    {
      Serial.println(F("Fdc ouvert libéré"));
      oled.setCursor(0,4);oled.println(vide);
    }

    if (Msg_cell_ok)
    {
      Msg_cell_ok=LOW;
      s=F("Cellule OK    ");
      Serial.println(s);
      oled.setCursor(0,6);oled.println(s);
    } 

    if (Msg_cell_nok)
    {
      Msg_cell_nok=LOW;
      s=F("Cellule coupee");
      Serial.println(s);
      oled.setCursor(0,6);oled.println(s);
    }

    if (Fd_Verrou)
    {
      Serial.println(F("Portail déverrouillé"));
      oled.setCursor(0,4);oled.println(vide);
    }

    if (Fm_Verrou | msgVerr)
    {
      s=F("Portail verrouille ");
      msgVerr=LOW;
      Serial.println(s);
      oled.setInvertMode(1);
      oled.setCursor(0,4);oled.println(s);
      oled.setInvertMode(0);
    }   
  }
    
  //réception des données depuis USB
  nombre=Serial.available() ; // nombre de caractères disponibles sur la liaison série
  if (nombre>0)
  {
    //Serial.println(nombre);
    for (i=0 ; i<nombre ; i++)
    {
      inByte = Serial.read();
      //Serial.print(inByte);
      //if (inByte==13) Serial.print("CR");
      //if (inByte==10) Serial.print("LF");
      if ((inByte!=13) & (inByte!=10)) chaineEnCours=chaineEnCours+inByte;
      if (inByte==13)
      {  
        //Serial.println("CR");Serial.println(chaineEnCours);
        if (menu) Tempo_menu=1;
        chaine=chaineEnCours;
        if (chaine=="") {demande_arret=!menu;Enter=HIGH;}  // pas de demande d'arret en mode menu
        //Serial.println();
        //Serial.print("chaine=");Serial.println(chaine);
        chaineEnCours=""; 
      }
    }
  }    

  if (chaine=="?") 
  {
    Serial.println(F("angle xx: Angle retard"));  
    Serial.println(F("m1 à m6 : 1 sinusoide sur 1..6"));
    Serial.println(F("md2 à 6 : 1/2 sinusoide sur 2..5"));
    tempo(1);
    Serial.println(F("sec     : Affiche la sinusoide du secteur\r\npos     : Affiche la position de l'encodeur")); 
    Serial.println(F("tar     : Avance en rapide")); 
    tempo(1);
    Serial.println(F("trr     : Recul en rapide\r\ntal     : Avance en lent\r\ntrl     : Recul en lent")); 
    tempo(1);  
    Serial.println(F("ENTREE  : Arret")); 
    Serial.println(F("e       : Etat des entrees"));   
    tempo(1);  
    Serial.println(F("simu    : Simu commande bornier"));
    Serial.println(F("menu    : Mode menu (touches 8/2 = < >)"));
    Serial.println(F("im      : Infos menu"));
    chaine="";
  }
  else

  if (chaine.substring(0,5)==F("angle"))
  {
    chaine.remove(0,5); // reste la valeur
    angle_retard=chaine.toInt();
    if ((angle_retard<0) | (angle_retard>70)) Serial.println(F("Erreur valeur angle"));
    else {Serial.print(F("Angle fixe a "));Serial.println(angle_retard);}
    chaine="";
  }
  else

  if (chaine==F("m1"))
  {
    Serial.println(F("mode 1"));
    mode1();
    chaine="";
  }
  else

  if (chaine==F("m2"))
  {
    Serial.println(F("mode 2"));
    mode2();
    chaine="";
  }
  else

  #ifdef modes_etendus
  if (chaine==F("m23"))
  {
    Serial.println(F("mode 23"));
    mode_23();
    chaine="";
  }
  else

  if (chaine==F("m34"))
  {
    Serial.println(F("mode 34"));
    mode_34();
    chaine="";
  }
  else
  
  if (chaine==F("m3"))
  {
    Serial.println(F("mode 3"));
    mode3();
    chaine="";
  }
  else

  if (chaine==F("md2"))
  {
    Serial.println(F("mode D2"));
    moded2();
    chaine="";
  }
  else

  if (chaine==F("md3"))
  {
    Serial.println(F("mode D3"));
    moded3();
    chaine="";
  }
  else
  #endif

  if (chaine==F("menu"))
  {
    simuMenu=HIGH;
    Serial.println(F("Mode MENU"));
    chaine="";
  }
  else

  if (chaine==F("8"))
  {
    Simu8=HIGH;
    chaine="";
  }
  else

  if (chaine==F("2"))
  {
    Simu2=HIGH;
    chaine="";
  }
  else
  
  if (chaine==F("simu"))
  {
    simu=HIGH;
    chaine="";
  }
  else

  if (chaine.substring(0,3)=="e")
  {
    Serial.print(F("Encodeur   ")); Serial.println(digitalRead(encod));
    Serial.print(F("Fc Ferme   ")); Serial.println(digitalRead(FcFerme));
    Serial.print(F("Fc Ouvert  ")); Serial.println(digitalRead(FcOuvert));
    tempo(1);
    Serial.print(F("Cellule    ")); Serial.println(digitalRead(Cellule));
    Serial.print(F("Commande   ")); Serial.println(digitalRead(Commande));
    Serial.print(F("Bouton ECH ")); Serial.println(digitalRead(BpEch));
    tempo(1);
    Serial.print(F("Bouton E   ")); Serial.println(digitalRead(BpE));
    Serial.print(F("Bouton +   ")); Serial.println(digitalRead(BpP));
    Serial.print(F("Bouton -   ")); Serial.println(digitalRead(BpM));
    
    chaine="";
  }
  else
  
  if (chaine==F("sec"))
  {
    Serial.print(F("Erreur="));Serial.println(erreur);
    for (i=0 ; i<=50 ; i++)
    {
      Serial.print(i);Serial.print(F(" "));
      Serial.println(val_secteur[i]);
    }
    chaine="";
  }
  else 

  if (chaine==F("pos"))
  {
    Serial.print(F("Position encodeur="));Serial.println(PosEncodeur);
    chaine="";
  }  
  else
   
  // avance rapide
  if (chaine==F("tar"))
  {  
    avance_rapide();
    chaine="";
  }
  else

  // recul rapide
  if (chaine==F("trr"))
  {
    recul_rapide();
    chaine="";
  }
  else

  // avance lente
  if (chaine==F("tal"))
  {
    avance_lente();
    chaine="";
  }
  else

  // recul lent
  if (chaine==F("trl"))
  {
    recul_lent();
    chaine="";
  }
  else
  
  if (chaine==F("im"))
  {
    Serial.print(F("Menu="));Serial.println(menu);
    Serial.print(F("ligne menu="));Serial.println(ligne_menu);
    Serial.print(F("Page="));Serial.println(PageMenu);
    Serial.print(F("Curseur="));Serial.println(curseur); 
    chaine="";
  }

  else
  if (chaine!="")
  {
   Serial.print(F("Commande inconnue:"));Serial.println(chaine);
   chaine="";
  }

  // demande de mouvement depuis le bornier (J4 bornes 2/7) ou radio -----------------------
  if (((Man_Bornier | radio) & !menu) | simu)  
  {  
    if (Man_Bornier) s=F("Commande bornier");
    if (radio) s=F("Commande radio  ");
    Man_Bornier=LOW;
    radio=LOW;   
    simu=LOW;
    Serial.println(s);
    oled.setCursor(0,5);oled.println(s);

    // si arreté sur un FdC 
    if (Fc_ouvert | Fc_ferme)
    {
      Serial.println(F("cas1"));
      if (!avance_cours & !recul_cours) 
      {
        if (Fc_ouvert) avance_rapide();
        if (Fc_ferme)  recul_rapide();
      }  
    }  
    
    else
    {
      // si pas arrété sur un FdC et pas de mvt en cours
      if (!avance_cours & !recul_cours)
      {
        Serial.println(F("cas2"));
        // dernier mvt était recul ou avance?
        if (recul) avance_rapide(); else recul_rapide(); 
      } 

      else
      // si mvt en cours
      {
        Serial.println(F("cas3"));
        // si (sequencement) mode Av -> arret -> recul -> arret
        if (PPS==1)
        {
          if (memo_lent) arret();
          if (avance_cours & !memo_lent) {avance_lente();tempo(Tps_dec);arret();}
          if (recul_cours & !memo_lent) {recul_lent();tempo(Tps_dec);arret();} 
        }
        else
        // si mode Av -> Re -> Av -> Re (PPS=0)
        {
          //regarder le dernier mouvement effectué pour inverser
          Serial.println(F("Ni ouvert ni ferme"));
          MemRecul=recul;
          MemAvance=avance;  
          if (MemRecul) 
          {
            if (posOk) avance_rapide();else avance_lente();
          }
      
          if (MemAvance) 
          {
            if (posOk) recul_rapide();else recul_lent();
          }
          // si pas de dernier mouvement, reculer en lent.
          if ((avance==LOW) & (recul==LOW)) recul_lent();
        }  
      }  
    }  
  }

  // arret ----------------------------------------------------------------
  if (demande_arret)
  {
     // si mvt en cours, décélérer avant arrêt
     if (recul_cours & !memo_lent)
     {
        recul_lent();   
        tempo(Tps_dec);
     }
     if (avance_cours & !memo_lent)
     {
        avance_lente();
        tempo(Tps_dec);
     }   
     Serial.println(F("Arret par terminal"));
     arret();
     chaine="";
  }

  // Boutons hors mode menu
  if (!menu)
  {
    if (Fm_P) {if (posOk) avance_rapide(); else avance_lente();}
    if (Fm_M) {if (posOk) recul_rapide(); else recul_lent();}
    if (Fm_Ech & (recul_cours | avance_cours))
    {
      Serial.println(F("Arret par BP"));
      if (!memo_lent & recul_cours) {recul_lent();tempo(Tps_dec);}
      if (!memo_lent & avance_cours) {avance_lente();tempo(Tps_dec);}   
      arret();
    }
  }
 
  // gestion écrans -----------------------------------------------
 
  // entrée en mode MENU
  if ( ((Temps_boutonE>5000) | simuMenu) & (!menu) )
  {
    arret();       // arret de tout mouvement
    Seq=0;         // Séquence 0
    Fm_E=LOW;      // reforcer pas front montant touche entrée puisque appui long  
    Tempo_menu=1;  // initialisation de la tempo menu
    simuMenu=LOW;
    Enter=LOW;
    menu=HIGH;
    curseur=HIGH;  // autoriser le curseur
    oled.clear();
    oled.set2X();
    oled.setCursor(15,0);oled.println(F("**MENU**")); 
    oled.set1X();
    decale=0;      // décalage 0 (descente plus bas que l'affichage)
    ligne_menu=premiere_ligneM; 
    derniere_ligne=derniere_ligneM;
    premiere_ligne=premiere_ligneM;
    offset=offset_M;
    fond_menu();
    PageMenu=1;
    oled.setCursor(0,offset);oled.write(">");
        
    // attendre relache bouton ENTREE
    do
    {
      tempo(1);
    }  
    while (digitalRead(BpE)==0);
  }

  // boutons en mode MENU
  if (menu)
  {
    // sortie du mode MENU
    if ( (Fm_Ech & (Seq==0)) | (Tempo_menu>Tempo_sortie_menu) )
    {
      Serial.println(F("sortie du menu"));
      simuMenu=LOW;   
      menu=LOW;
      curseur=LOW;
      PageMenu=0;
      Tempo_menu=0;   // figeage à 0 de la tempo menu
      Ecran_base();
      msgVerr=Verrou;  // provoque le message verrouillage si verrouillé
      
    }

    // descente curseur
    if ( (Fm_P | Simu2) & menu & curseur)  
    {
      Enter=LOW;
            
      if (ligne_menu<derniere_ligne)
      {
        if (ligne_menu-decale+offset<8)
        {
          oled.setCursor(0,coordY());oled.println(" ");
          ++ligne_menu;
          oled.setCursor(0,coordY());oled.println(">");
        }
        else 
        {
          // on descend plus bas que la dernière ligne déclarée pour l'affichage
          if (ligne_menu<derniere_ligne) 
          { 
            ++decale;
            ++ligne_menu;
            if (PageMenu==1) fond_menu();
            if (PageMenu==3) fond_telecom();  
            oled.setCursor(0,coordY());oled.println(">");
          }          
        }       
        Seq=0;
      }
      Simu2=LOW;
      //Serial.print("ligne menu=");Serial.print(ligne_menu);Serial.print(" decale=");Serial.print(decale);Serial.print(" offset=");Serial.println(offset);
    }
    
    // montée curseur
    if ( (Fm_M | Simu8) & menu & curseur)
    {
      Enter=LOW;
      if (ligne_menu-decale>premiere_ligne)
      {
        oled.setCursor(0,coordY());oled.println(" ");
        --ligne_menu;
        //Serial.print("A");Serial.println(ligne_menu);
        oled.setCursor(0,coordY());oled.println(">");
      } 
      else 
      if (decale>0)
      {
        --decale;
        --ligne_menu;
        //Serial.print("B");Serial.println(ligne_menu);
        if (PageMenu==1) fond_menu();
        if (PageMenu==3) fond_telecom();
        oled.setCursor(0,coordY());oled.println(">");
      }
      Seq=0;
      Simu8=LOW;
      //Serial.print("ligne menu=");Serial.print(ligne_menu);Serial.print(" decale=");Serial.print(decale);Serial.print(" offset=");Serial.println(offset);
    }

    // écran 1
    // apprentissage
    if ((PageMenu==1) & menu) 
    {
      if ( (ligne_menu==ligne_aprentiss) & (Enter | Fm_E) ) 
      {
        curseur=LOW;
        Tempo_menu=0;
        Enter=LOW;  
        oled.clear();
        oled.set2X();
        oled.print(F("Apprentiss."));
        oled.set1X();
        Serial.println(F("Apprentissage"));
        arret();  
        // si on est sur le Fdc arrière, avancer pour se dégager
        if (Fc_ouvert) 
        {
           avance_lente(); // si ouvert, avancer se dégager
           oled.setCursor(0,ligne_encodeur);oled.print(F("Position="));
           oled.setCursor(0,4);oled.print(F("Degag arr"));
           Serial.println(F("Dégagement arrière"));
           do
             traitement();
           while ( !Fc_ouvert & (Serial.available()==0) & !Fm_Ech) ;
        }
        tempo(20);   // avancer un peu
        arret();
        tempo(20);   
        // reculer en lent vers le FdC arrière pour fixer l'origine codeur
        s=F("prise origine");
        oled.setCursor(0,4);oled.println(s);
        Serial.println(s);
        recul_lent(); // reculer pour trouver le FDC arrière
        do
          traitement();
        while ( !Fc_ouvert & (Serial.available()==0) & !Fm_Ech);
        arret();
        if (!Fm_Ech) // si pas appui sur bp ECH
        {
          s=F("Origine faite");
          Serial.println(s);
          oled.setCursor(0,4);oled.println(s); 
          // aller chercher le FDC avant pour relever la valeur codeur en son point
          tempo(20);
          avance_lente();
          s=F("Avance vers FDC avant");
          oled.setCursor(0,4);oled.println(s);
          Serial.println(s);
          do
            traitement();
          while ( (!Fc_ferme) & (Serial.available()==0) & !Fm_Ech );
          inByte = Serial.read();  // vide tampon 
          arret();
          ecrit_eprom();   // mémorise les positions avance et recul ralentissement
          s=F("Fini                 ");
          oled.setCursor(0,4);oled.println(s);
          Serial.println(s);
        }  
        tempo(20);
        Enter=LOW;
        simuMenu=HIGH;  // retour en page menu
        menu=LOW;
        Tempo_menu=1;
      }
    
      // Paramètre sens d'ouverture
      if ((ligne_menu==ligne_Param_sens) & (PageMenu==1))
      {
        if ((Seq==0) & (Enter | Fm_E))
        {
          curseur=LOW;
          oled.setInvertMode(1);
          Sens_Ouv_P=Sens_Ouv;            // variable provisoire
          oled.setCursor(108,coordY());oled.print(Sens_Ouv_P);
          Seq=1;
          Enter=LOW;
          Fm_E=LOW;
          Tempo_menu=1;
        }  
        if (Seq==1)
        {
          if (Fm_P | Simu8) 
          {
            Sens_Ouv_P=1;
            oled.setCursor(108,coordY());oled.print(Sens_Ouv_P);
            Simu8=LOW;
          }
          if (Fm_M | Simu2) 
          {
            Sens_Ouv_P=0;
            oled.setCursor(108,coordY());oled.print(Sens_Ouv_P);
            Simu2=LOW;
          }
          if (Fm_E | Enter) // validation
          {
            Sens_Ouv=Sens_Ouv_P;
            oled.setInvertMode(0);
            oled.setCursor(108,coordY());oled.print(Sens_Ouv);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }
          if (Fm_Ech)  // annulation
          {
            oled.setInvertMode(0);
            oled.setCursor(108,coordY());oled.print(Sens_Ouv);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }  
        }
      }  
      
      // paramètre PPS
      if ((ligne_menu==ligne_Param_PPS) & (PageMenu==1))
      {
        if ((Seq==0) & (Enter | Fm_E))
        {
          curseur=LOW;
          oled.setInvertMode(1);
          PPS_P=PPS;            // variable provisoire
          oled.setCursor(84,coordY());oled.print(PPS_P);
          Seq=1;
          Enter=LOW;
          Fm_E=LOW;
        }  
        if (Seq==1)
        {
          if (Fm_P | Simu8) 
          {
            PPS_P=1;
            oled.setCursor(84,coordY());oled.print(PPS_P);
            Simu8=LOW;
          }
          if (Fm_M | Simu2) 
          {
            PPS_P=0;
            oled.setCursor(84,coordY());oled.print(PPS_P);
            Simu2=LOW;
          }
          if (Fm_E | Enter) // validation
          {
            PPS=PPS_P;
            oled.setInvertMode(0);
            oled.setCursor(84,coordY());oled.print(PPS);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }
          if (Fm_Ech)  // annulation
          {
            oled.setInvertMode(0);
            oled.setCursor(84,coordY());oled.print(PPS);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }  
        } 
      }
      if ((ligne_menu==ligne_telecom) & (PageMenu==1))
      {
        if ((Seq==0) & (Fm_E | Dem_Telecom | Enter)) // validation
        {
          Fm_E=LOW;
          Enter=LOW;
          Dem_Telecom=LOW;
          curseur=HIGH;
          oled.clear();
          oled.set2X();
          oled.setCursor(0,0);oled.print(Nbre_telecom);oled.println(F("telecomm.")); 
          oled.set1X();
          oled.setCursor(0,ligne_telecomA+Offset_T-1);oled.println(F(">Ajouter telecom."));
          oled.setCursor(0,ligne_telecomL+Offset_T-1);oled.println(F(" Liste/Suppr des telecom"));
                  
          premiere_ligne=premiere_ligneT;  
          derniere_ligne=derniere_ligneT; //ligne_menu+offset-decale-1
          offset=Offset_T;
          ligne_menu=ligne_telecomA;
          Seq=0;
          decale=0;
          PageMenu=2;
        }
      }
        
      // Sauvegarde EPROM
      if ((ligne_menu==ligne_eprom) & (PageMenu==1))
      {
        if (Fm_E | Enter) // validation
        {
          Enter=LOW;
          oled.setCursor(6,coordY());
          oled.setInvertMode(1);
          oled.println(F("Sauvegarde EPROM")); 
          ecrit_eprom(); 
          tempo(10);
          oled.setCursor(6,coordY());
          oled.setInvertMode(0);
          oled.println(F("Sauvegarde EPROM"));       
        }
      }
        
      if ((ligne_menu==ligne_ES) & (PageMenu==1))
      {
        if ((Seq==0) & (Fm_E | Enter)) // validation
        {
          curseur=LOW;
          Enter=LOW;
          oled.clear();
          oled.set2X();
          oled.setCursor(0,0);oled.println(F("**Entrees**")); 
          oled.set1X();
          oled.setCursor(0,3);
          oled.println(F("Cellule (8-CX):"));
          oled.println(F("Commande(7)   :"));
          oled.println(F("Fc recul      :"));
          oled.println(F("Fc avance     :"));
          oled.println(F("Encodeur      :"));
          Seq=1;
          Tempo_menu=2;
          Enter=LOW;         
        }
        // affichage dynamique des entrées
        if (Seq==1)
        {
          oled.setCursor(100,3),oled.print(digitalRead(Cellule));
          oled.setCursor(100,4),oled.print(digitalRead(Commande));
          oled.setCursor(100,5),oled.print(digitalRead(FcOuvert));
          oled.setCursor(100,6),oled.print(digitalRead(FcFerme));
          oled.setCursor(100,7),oled.print(digitalRead(encod));
          if (Fm_Ech)  // annulation
          {
            // retour en page menu
            menu=LOW;
            simuMenu=HIGH;
          }  
        }      
      }
      
      // paramètre temps de fonctionnement maximal
      if ((ligne_menu==ligne_tpsmax) & (PageMenu==1))
      {
        if ((Seq==0) & (Enter | Fm_E))
        {
          curseur=LOW;
          oled.setInvertMode(1);
          Tps_fonc_P=Tps_fonctionnement;            // variable provisoire
          oled.setCursor(108,coordY());oled.print(Tps_fonc_P);
          Seq=1;
          Fm_E=LOW;
          Enter=LOW;
        }  
        if (Seq==1)
        {
          if ((Fm_P | Simu2) & (Tps_fonc_P<99)) 
          {
            ++Tps_fonc_P;
            oled.setCursor(108,coordY());oled.print(Tps_fonc_P);
            Simu2=LOW;
          }
          if ((Fm_M | Simu8) & (Tps_fonc_P>2))  
          {
            --Tps_fonc_P;
            oled.setCursor(108,coordY());oled.print(Tps_fonc_P);
            Simu8=LOW;
          }
          if (Fm_E | Enter) // validation
          {
            Tps_fonctionnement=Tps_fonc_P;
            oled.setInvertMode(0);
            oled.setCursor(108,coordY());oled.print(Tps_fonctionnement);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }
          if (Fm_Ech)  // annulation
          {
            oled.setInvertMode(0);
            oled.setCursor(108,coordY());oled.print(Tps_fonctionnement);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }  
        } 
      }
      // paramètre temps d'accélération
      if ((ligne_menu==ligne_acc) & (PageMenu==1))     
      {
        if ((Seq==0) & (Enter | Fm_E))
        {
          curseur=LOW;
          oled.setInvertMode(1);
          Tps_accP=Tps_acc;            // variable provisoire
          oled.setCursor(66,coordY());oled.print(Tps_accP);
          Seq=1;
          Fm_E=LOW;
          Enter=LOW;
        }  
        if (Seq==1)
        {
          if ((Fm_P | Simu2) & (Tps_accP<20)) 
          {
            ++Tps_accP;
            oled.setCursor(66,coordY());oled.print(Tps_accP);
            Simu2=LOW;
          }
          if ((Fm_M | Simu8) & (Tps_acc>2))  
          {
            --Tps_accP;
            oled.setCursor(66,coordY());oled.print(Tps_accP);oled.print(" ");
            Simu8=LOW;
          }
          if (Fm_E | Enter) // validation
          {
            Tps_acc=Tps_accP;
            oled.setInvertMode(0);
            oled.setCursor(66,coordY());oled.print(Tps_acc);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }
          if (Fm_Ech)  // annulation
          {
            oled.setInvertMode(0);
            oled.setCursor(66,coordY());oled.print(Tps_acc);oled.print(" ");
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }  
        }  
      }
      // paramètre décélération
      if ((ligne_menu==ligne_dec) & (PageMenu==1))     
      {
        if ((Seq==0) & (Enter | Fm_E))
        {
          curseur=LOW;
          oled.setInvertMode(1);
          Tps_decP=Tps_dec;            // variable provisoire
          oled.setCursor(66,coordY());oled.print(Tps_decP);
          Seq=1;
          Fm_E=LOW;
          Enter=LOW;
        }  
        if (Seq==1)
        {
          if ((Fm_P | Simu2) & (Tps_accP<20)) 
          {
            ++Tps_decP;
            oled.setCursor(66,coordY());oled.print(Tps_decP);
            Simu2=LOW;
          }
          if ((Fm_M | Simu8) & (Tps_acc>2))  
          {
            --Tps_decP;
            oled.setCursor(66,coordY());oled.print(Tps_decP);oled.print(" ");
            Simu8=LOW;
          }
          if (Fm_E | Enter) // validation
          {
            Tps_dec=Tps_decP;
            oled.setInvertMode(0);
            oled.setCursor(66,coordY());oled.print(Tps_dec);
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }
          if (Fm_Ech)  // annulation
          {
            oled.setInvertMode(0);
            oled.setCursor(66,coordY());oled.print(Tps_dec);oled.print(" ");
            Seq=0;
            Enter=LOW;
            curseur=HIGH;
          }  
        }  
      }
    }
   
    // page télécommandes
    if (PageMenu==2)
    {
      //Serial.print("Page 2");Serial.println(curseur);
      if (ligne_menu==ligne_telecomA) 
      {
        if ((Seq==0) & (Fm_E | Enter))
        {
          if (Nbre_telecom>=Nbre_Max_telecom)
          {
            oled.setCursor(0,6);oled.println(F("Nombre maxi de")); 
            oled.setCursor(0,7);oled.println(F("telecommandes")); 
            tempo(20);
          }
          else
          {
            Enter=LOW;
            curseur=LOW;
            oled.setCursor(0,6);oled.println(F("Appuyer sur le bouton de la")); 
            oled.setCursor(0,7);oled.println(F("telecom. a ajouter "));  
            Seq=1;
          }  
        }
        if (Seq==1)
        {
          // attente message de la télécommande à ajouter
          Code=0;
          attendre=0;
          do
          {
            tempo(2);
            ++attendre;
          }  
          while ((attendre<100) & (Code==0));  // attend 100x0,2s = 20s

          if (Code!=0)
          {
            oled.setCursor(0,6);oled.println(vide); 
            oled.setCursor(0,7);oled.println(vide); 
            oled.setCursor(0,6);oled.print(Code);
            oled.print(" ");
            oled.print(Nbit);oled.print(F("b "));
            oled.print(F("Pr:"));oled.print(Protocole);
            // vérifier si la télécommande est déja présente en EPROM
            i=-1; 
            do
            {
              ++i;
            }
            while ((i<Nbre_telecom) & (telecom[i]!=Code)) ; 
            if (telecom[i]==Code) {oled.setCursor(0,7);oled.print(F("Telecom deja memorisee"));}
            else
            {
              ++Nbre_telecom;
              telecom[Nbre_telecom-1]=Code;
              oled.setCursor(0,7);oled.print(F("Ajoute")); 
            }
            tempo(80);
          }   
          Seq=0;
          // retourner en page télécommandes
          ligne_menu=ligne_telecom; 
          Fm_E=LOW; 
          PageMenu=1; 
          Dem_Telecom=HIGH;    
        }
      }
     
      if ((ligne_menu==ligne_telecomL) & (PageMenu==2))
      {
        if ((Seq==0) & (Fm_E | Enter | Dem_Liste_Tel))
        {
          Dem_Liste_Tel=LOW;
          Enter=LOW;
          oled.clear();
          oled.print(Nbre_telecom);
          oled.print(F(" telecommandes"));
          offset=1;
          Seq=0;
          // gestion curseur        
          ligne_menu=1;
          premiere_ligne=1;
          derniere_ligne=Nbre_telecom;
          curseur=HIGH;      
          decale=0;
          PageMenu=3;
          fond_telecom();
          oled.setCursor(0,offset);oled.write(">");
        }  
      }
    }
    
    if (PageMenu==3)
    {
      if (Seq==0)  
      {  
        // suppression télécommande
        if ( ((Temps_boutonE>5000) | Enter) & (Nbre_telecom>0) )
        {
          Enter=LOW;
          oled.setCursor(0,7);
          oled.print(F("Supp telecommande "));oled.print(ligne_menu);
          // à la première itération on supprime la télécommande ligne_menu-1 soit i-1
          for (i=ligne_menu ; i<Nbre_telecom ; i++)
          {
            telecom[i-1]=telecom[i];
          }
          --Nbre_telecom;
          telecom[Nbre_telecom]=0;
          //for (i=0 ; i<Nbre_telecom ; i++)
          //{
          //  Serial.print(i);Serial.print("/");Serial.println(telecom[i]);
          //}          
          ligne_menu=LOW;
          tempo(50);
          PageMenu=2; 
          Dem_Liste_Tel=HIGH;
          premiere_ligne=1;
          derniere_ligne=Nbre_telecom;
          ligne_menu=ligne_telecomL;
          Seq=0;
        }  
      }  
    }
  }      
}
