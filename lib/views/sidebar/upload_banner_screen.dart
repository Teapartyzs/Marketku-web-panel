import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_marketku/controllers/banner_controller.dart';
import 'package:web_marketku/models/banner.dart';
import 'package:web_marketku/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = "\banner-upload";
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final BannerController _bannerController = BannerController();
  late Future<List<BannerModel>> bannerData;
  dynamic banner;

  pickBannerImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        banner = result.files.first.bytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    bannerData = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.all(16),
            child: const Text(
              "Banners",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: const Divider(
              color: Colors.grey,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Choose Banner:",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: banner != null
                      ? Image.memory(banner)
                      : const Text(
                          "Select banner",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  pickBannerImage();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: const Text(
                  "+ Add banners",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      banner = null;
                    });
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                    onPressed: () async {
                      _bannerController.uploadBanner(
                        pickImage: banner,
                        context: context,
                        onSuccess: () {
                          setState(() {
                            bannerData = BannerController().loadBanners();
                          });
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          BannerWidget(
            bannerData: bannerData,
          )
        ],
      ),
    );
  }
}
