import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PanelController _panelController = PanelController();
  bool _boolopacity = true;
  double opacity_val = 1;
  double imageTopPositionPortrait = 410;
  double imageTopPositionLandscape = 20;
  double imageTopPosition = 410;
 
  
  final String whatsappNumber = '+916205840930';
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  void _opacitychanger() {
    setState(() {
      if (_boolopacity == true) {
        opacity_val = 0;
        _boolopacity = false;
      } else {
        opacity_val = 1;
        _boolopacity = true;
      }
    });
  }

  void handlePanelSlide(double slideAmount) {
    // Determine the current orientation
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Update the position of the image based on the orientation
    setState(() {
      if (isPortrait) {
        imageTopPositionPortrait = 410 - slideAmount * 230;
      } else {
        imageTopPositionLandscape = 20 + slideAmount * 155;
      }
    });
  }

  void handleOrientationChange(Orientation orientation, double slideAmount) {
    // Close the sliding panel
    // _panelController.close();

    // Update the position of the image based on the orientation
    setState(() {
      if (orientation == Orientation.portrait) {
        if (_panelController.isPanelOpen) {
          _panelController.close();
        }
        imageTopPositionPortrait = 410 - slideAmount * 230;
      } else {
        _panelController.close();
        imageTopPositionLandscape = 20 + slideAmount * 155;
      }
    });
  }

  final List<Project> projects = [
    Project(
      name: 'Bank Chat Bot',
      url: Uri.parse('https://github.com/loopassembly/intractive-bot.git'),
    ),
    Project(
      name: 'Restaurant Project',
      url: Uri.parse(
          'https://github.com/loopassembly/Euphoria-rest-web-api.git'),
    ),
    Project(
      name: 'Decentralized Password Manager',
      url: Uri.parse('https://github.com/loopassembly/password-manager.git'),
    ),

    // Project(name: "Lightbulb", url: Uri.parse("https://www.litebulb.xyz/")),
    // Project(name: "looopassembly", url: Uri.parse("https://loopassembly.in/"))
  ];

  bool isContentLoaded = false; // Track whether the content is loaded

  Future<void> loadContent() async {
    // Simulate loading by adding a delay (you can replace this with your actual loading logic)
    await Future.delayed(Duration(seconds: 2));

    // Set isContentLoaded to true once the content is loaded
    isContentLoaded = true;
  }

  Widget buildLoadingScreen() {
    // You can customize your loading screen here
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();

    // Loop through the projects list and fetch metadata for each URL
    for (Project project in projects) {
      _getMetadata(project.url.toString());
    }
  }

  void _getMetadata(String url) async {
    bool _isValid = _getUrlValid(url);
    if (_isValid) {
      Metadata? _metadata = await AnyLinkPreview.getMetadata(
        link: url,
        cache: Duration(days: 7),
        proxyUrl: "https://cors-anywhere.herokuapp.com/", // Needed for web app
      );
      debugPrint("URL6 => ${_metadata?.title}");
      debugPrint(_metadata?.desc);
    } else {
      debugPrint("URL is not valid");
    }
  }

  bool _getUrlValid(String url) {
    bool _isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https'],
      hostWhitelist: ['https://youtube.com/'],
      hostBlacklist: ['https://facebook.com/'],
    );
    return _isUrlValid;
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        // if (!isContentLoaded) {
        //   isContentLoaded = true;

        //   // Show loading screen while waiting for content to load
        //   return buildLoadingScreen();
        // } else {
        return WillPopScope(
          onWillPop: () async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirm Exit'),
                content: const Text('Do you really want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          child: Stack(
            children: <Widget>[
              // Cover Photo
              SlidingUpPanel(
                // onPanelOpened: () {
                //   _opacitychanger();
                // },
                // onPanelClosed: () => _opacitychanger(),
                onPanelSlide: handlePanelSlide,
                controller: PanelController(),

                backdropEnabled: true,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                minHeight: 350, // Set the minimum height of the panel
                maxHeight: MediaQuery.of(context).size.height - 200,
                // Set the maximum height of the panel
                panel: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                            left: 25,
                            top: 20,
                          ),
                          child: const Text(
                            'Loopassemly',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: const Text(
                            'Full stack developer',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 25,
                            top: 20,
                            right: 7,
                          ),
                          child: const Text(
                            'Hello everyone! I am a full-stack developer and AI/ML nerd who is passionate about creating innovative and cutting-edge technology. I am constantly working day and night to turn my ideas into reality. I specialize in creating web and mobile applications, as well as implementing AI/ML algorithms to improve user experience. I am always on the lookout for new and exciting projects to work on, and am always eager to learn and grow as a developer. ',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 25,
                              top: 20,
                              right: 7,
                            ),
                            child: const Text(
                              "Service",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 25,
                              top: 20,
                              right: 7,
                            ),
                            child: const Text(
                              "I'm  the founder and CEO of Loopit, a cutting-edge SaaS (Software as a Service) company dedicated to simplifying your software needs.\n At Loopit, our mission is to provide individuals and businesses with seamless solutions to their software requirements. We understand that navigating the ever-evolving world of technology can be daunting, which is why we're here to make it effortless for you.\n With a diverse portfolio of services, Loopit is your one-stop destination for all things digital. We offer top-notch services in web development and app development, crafting stunning and functional digital experiences tailored to your unique needs. Whether you're looking to establish an online presence, launch a new app, or revamp your existing digital platform, we've got you covered.\n Additionally, we specialize in the creation of Discord bots and Telegram bots, enhancing your communication and automation capabilities on these popular platforms. Our bots are designed to streamline your operations, engage your community, and provide valuable insights.\n Data is the lifeblood of the digital age, and Loopit excels at web scraping and automation solutions. We can help you gather valuable data from the web, automate repetitive tasks, and save you time and effort. Our custom scripts are tailored to your specific needs, ensuring efficiency and accuracy in your operations.\n Beyond software, we understand that holistic solutions are essential for success. That's why Loopit is committed to delivering results across various fields. Our multidisciplinary approach allows us to tackle a wide range of challenges, ensuring that your business operates at its peak potential.\n Join us on this exciting journey as we transform the way you interact with technology. At Loopit, innovation knows no bounds, and we're here to turn your ideas into reality. Reach out to us today and let's explore how Loopit can empower your digital presence and business operations. Your software requirements are our passion, and your success is our mission. Let's Loopit together!",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 25,
                              top: 20,
                              right: 7,
                            ),
                            child: const Text(
                              "Products",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            )),
                        Container(
                          // margin: EdgeInsets.only(left: 14),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: projects.map((project) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        0), // Adjust the space between items
                                child: ListTile(
                                  title: AnyLinkPreview.builder(
                                      link: project.url.toString(),
                                      itemBuilder:
                                          (context, metadata, imageProvider) {
                                        if (metadata.image == null) {
                                          // If metadata or image is not available, show a loading spinner or placeholder image
                                          return CircularProgressIndicator(); // You can replace this with your preferred loading indicator
                                        }

                                        return Card(
                                          elevation: 10,
                                          // Adjust the elevation as needed
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: const BorderSide(
                                                color: Colors.grey, width: 1),
                                            // Adjust the border radius as needed
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (imageProvider != null)
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20, bottom: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (metadata.title != null)
                                                      Text(
                                                        metadata.title!,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    const SizedBox(height: 5),
                                                    if (metadata.desc != null)
                                                      Text(
                                                        metadata.desc!,
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    Text(
                                                      metadata.url ??
                                                          project.url
                                                              .toString(),
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                  // Adjust padding
                                  onTap: () async {
                                    final url = project.url;
                                    if (!await launchUrl(url)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Could not launch URL"),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                header: Center(
                  child: Container(
                    
                    margin: EdgeInsets.symmetric(vertical: 13,horizontal: MediaQuery.of(context).size.width/2-25),
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 31, 30, 30),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                footer: GlassmorphicContainer(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  borderRadius: 20,
                  blur: 0.6,
                  alignment: Alignment.centerLeft,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.9),
                      const Color(0xFFFFFFFF).withOpacity(0.9),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.8),
                      const Color((0xFFFFFFFF)).withOpacity(0.8),
                    ],
                  ),
                  child: Container(
                    height: 30,
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri whatsappUri =
                            Uri.parse('https://wa.me/$whatsappNumber');
                        // final Uri url = Uri.parse("https://loopassembly.in") ;
                        if (!await launchUrl(whatsappUri)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Could not launch URL"),
                            ),
                          );
                        }
                        ;
                        // Add your contact logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded edges
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Contact Me',
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // Cover Photo
                      Container(
                        height: 450,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/profile.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   top: orientation == Orientation.portrait
              //       ? imageTopPositionPortrait
              //       : imageTopPositionLandscape,
              //   right: 0,
              //   left: 0,
              //   child: AnimatedOpacity(
              //     opacity: opacity_val,
              //     duration: const Duration(milliseconds: 100),
              //     child: Container(
              //       width: 40, // Set the desired width
              //       height: 40, // Set the desired height
              //       decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //         image: DecorationImage(
              //           image: AssetImage('assets/arrow.png'),
              //           fit: BoxFit.contain, // Adjust the fit mode as needed
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: 12,
                right: 170,
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  onPressed: () async {
                    final Uri url =
                        Uri.parse("https://github.com/loopassembly");
                    if (!await launchUrl(url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Could not launch URL"),
                        ),
                      );
                    }
                    // Add your FAB action here
                  },
                  backgroundColor: Colors.black87,
                  child: const Icon(
                    FontAwesomeIcons.github,
                    color: Color.fromARGB(255, 250, 249, 249),
                    size: 20,
                  ),
                  // Customize the FAB's background color
                ),
              ),
              Positioned(
                bottom: 12,
                right: 120,
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  onPressed: () async {
                    final Uri url =
                        Uri.parse("https://www.linkedin.com/in/loopassembly/");
                    if (!await launchUrl(url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Could not launch URL"),
                        ),
                      );
                    }
                    // Add your FAB action here
                  },
                  backgroundColor: Colors.black87,
                  child: const Icon(
                    FontAwesomeIcons.linkedinIn,
                    color: Color.fromARGB(255, 245, 242, 242),
                    size: 20,
                  ),
                  // Customize the FAB's background color
                ),
              ),
              Positioned(
                bottom: 12,
                right: 70,
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(
                        "https://stackoverflow.com/users/14141164/loopassembly");
                    if (!await launchUrl(url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Could not launch URL"),
                        ),
                      );
                    }
                    // Add your FAB action here
                  },
                  backgroundColor: Colors.black87,
                  child: const Icon(
                    FontAwesomeIcons.stackOverflow,
                    color: Color.fromARGB(255, 245, 242, 242),
                    size: 20,
                  ),
                  // Customize the FAB's background color
                ),
              ),
              Positioned(
                bottom: 12,
                right: 22,
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  onPressed: () async {
                    final Uri url = Uri.parse("https://loopassembly.in");
                    if (!await launchUrl(url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Could not launch URL"),
                        ),
                      );
                    }
                    // Add your FAB action here
                  },
                  backgroundColor: Colors.black87,
                  child: const Icon(
                    FontAwesomeIcons.globe,
                    color: Color.fromARGB(255, 245, 242, 242),
                    size: 20,
                  ),
                  // Customize the FAB's background color
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class Project {
  final String name;
  final Uri url;

  Project({
    required this.name,
    required this.url,
  });
}

// add 