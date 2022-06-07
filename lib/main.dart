import 'package:flutter/material.dart';
import 'package:histoire/histoire.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: HistoireApp(),
        ),
      ),
    ),
  );
}

class HistoireApp extends StatefulWidget {
  const HistoireApp({Key? key}) : super(key: key);

  @override
  State<HistoireApp> createState() => _HistoireAppState();
}

class _HistoireAppState extends State<HistoireApp> {
  int numeroEtape = 0; //initialiser les étapes à l'index 0

  //creation d'une liste d'histoire composée de : un contexte, le premier choix, le deuxième choix
  List<Histoire> listHistoire = [
    Histoire(
      "Vous venez de crevez un pneu à St André. Vous n'avez pas de téléphone vous décidez de faire du stop. Une ford fiesta rouge s'arrête et le conducteur vous demande si vous voulez qu'il vous dépanne.",
      "Vous lui remerciez et vous montez dans la voiture",
      "Vous lui demandez s'il n'est pas un meurtrier avant !",
    ),
    Histoire(
      "Il acquiesce de la tête sans faire attention à la question.",
      "Au moins il est honnête. Vous montez !",
      "Attends, mais je sais comment changer un pneu voyons !",
    ),
    Histoire(
      "Lorsqu'il commence à conduire, il vous demande d'ouvrir la boite à gant. À l’intérieur, vous trouverez un couteau ensanglanté, deux doigts coupés et un CD de T-Matt.",
      "J'adore T-Matt, je lui donne le CD.",
      " C'est lui ou moi, je prends le couteau et je le poignarde.",
    ),
    Histoire(
      "Woaw ! Quelle évasion !",
      "Recommencer",
      "",
    ),
    Histoire(
      "En traversant la route du littoral, vous réfléchissez à la sagesse douteuse de poignarder quelqu’un pendant qu’il conduit une voiture dans laquelle vous êtes.",
      "Recommencer",
      "",
    ),
    Histoire(
      "Vous vous faites un bon dalon et vous chantez le dernier son de T-matt ensemble. Il vous dépose à Cambaie et il vous demande si vous connaissez un bon endroit pour jeter un corps.",
      "Recommencer",
      "",
    ),
  ];

  //lors d'un clic l'étape (contexte) change en fonction de la réponse sélectionnée
  click(bool b) {
    setState(() {
      if (numeroEtape == 0 && b == true) {
        numeroEtape ==
            2; //si à l'étape 0 on sélectionne le choix 1 alors on va à l'étape 2
      } else if (numeroEtape == 0 && b == false) {
        numeroEtape ==
            1; //si à l'étape 0 on sélectionne le choix 2 alors on va à l'étape 1
      } else if (numeroEtape == 1 && b == true) {
        numeroEtape ==
            2; //si à l'étape 1 on sélectionne le choix 1 alors on va à l'étape 2
        if (numeroEtape == 1 && b == false) {
          numeroEtape ==
              3; //si à l'étape 1 on sélectionne le choix 2 alors on va à l'étape 3
        }
      } else if (numeroEtape == 2 && b == true) {
        numeroEtape ==
            5; //si à l'étape 2 on sélectionne le choix 1 alors on va à l'étape 5
      }
      if (numeroEtape == 2 && b == false) {
        numeroEtape ==
            4; //si à l'étape 2 on sélectionne le choix 2 alors on va à l'étape 4
      }
    });
    numeroEtape++; // pour pouvoir changer d'étape
    if (numeroEtape >= listHistoire.length) {
      setState(() {
        numeroEtape = 0;
      });

      //permet d'afficher une alerte à la fin de l'histoire, elle permet de recommencer l'histoire depuis le début
      Alert(
        context: context,
        title: "L'histoire est terminée",
        desc: "Vous pouvez recommencer",
        buttons: [
          DialogButton(
            child: Text(
              "Replay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex:
                2, // le texte prendra plus d'espace que les boutons sur l'écran,car par défaut le flex est de 1
            child: Center(
              child: Text(
                listHistoire[numeroEtape].etape,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () => click(
                  true), //le premier bouton correspond au booléen True = choix 1
              child: Text(
                listHistoire[numeroEtape].reponse1,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          //créer un espace entre les 2 boutons grâce à une box
          SizedBox(
            height: 20,
          ),

          Expanded(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red), //mettre une couleur au bouton
              ),
              onPressed: () => click(
                  false), //le deuxième bouton correspond au booléen False = choix 2
              child: Text(
                listHistoire[numeroEtape].reponse2,
                style: TextStyle(
                    color:
                        Colors.white), //mettre une couleur au texte du bouton
              ),
            ),
          ),
        ],
      ),
    );
  }
}
