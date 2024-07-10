
part of 'home_page.dart';
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);
  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}
class _HomePageWidgetState extends State<HomePageWidget>   {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(height: 100,),
            Center(
              child: SizedBox(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // ElevatedButton(
                    //   onPressed: () {
                    //     LocaleController().chingeLanguage(languageCode: 'ar');
                    //   },
                    //   child: Text("Arabic"),
                    // ),
                    ElevatedButton(
                      onPressed: () {

                        setState(() {

                        });


                      },
                      child: Text("my home page"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0).copyWith(bottom: 140),
              child: SubstringHighlight(
                text: "my home page",
                textAlign: TextAlign.center,
                terms: Command.commands,
                textStyle: const TextStyle(

                  color: Colors.teal,
                  fontSize: 30,
                ),
                textStyleHighlight: const TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}