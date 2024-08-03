import 'package:agri_ai/app/data/models/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';

class QuestionMessage extends StatelessWidget {
  final Question question;

  const QuestionMessage({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text('Q'.tr, style: TextStyle(color: Colors.black)),
          ),
          SizedBox(width: 8.0.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('You'.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    SizedBox(height: 4.h),
                    Text(question.createdAt ?? '', style: TextStyle(color: Colors.grey, fontSize: 10.sp)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(question.content ?? '', style: TextStyle(fontSize: 15.sp)),
                if (question.questionMedia != null && question.questionMedia!.isNotEmpty) SizedBox(height: 8.h),
                if (question.questionMedia != null && question.questionMedia!.isNotEmpty) _buildImageGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    List<String> imageUrls = question.questionMedia!.map((media) => media.mediaUrl ?? '').toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        double maxHeight = 350; // Maximum height for the image container

        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(2), // Border thickness
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: _buildImageContent(imageUrls, maxWidth, maxHeight),
          ),
        );
      },
    );
  }

  Widget _buildImageContent(List<String> imageUrls, double maxWidth, double maxHeight) {
    switch (imageUrls.length) {
      case 1:
        return _buildSingleImage(imageUrls[0], maxWidth, maxHeight);
      case 2:
        return _buildTwoImages(imageUrls, maxWidth, maxHeight);
      case 3:
        return _buildThreeImages(imageUrls, maxWidth, maxHeight);
      case 4:
        return _buildFourImages(imageUrls, maxWidth, maxHeight);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSingleImage(String imageUrl, double maxWidth, double maxHeight) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: _buildImage(imageUrl, maxWidth, maxHeight),
      ),
    );
  }

  Widget _buildTwoImages(List<String> imageUrls, double maxWidth, double maxHeight) {
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: _buildImage(imageUrls[0], maxWidth, maxHeight),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: _buildImage(imageUrls[1], maxWidth, maxHeight),
          ),
        ),
      ],
    );
  }

  Widget _buildThreeImages(List<String> imageUrls, double maxWidth, double maxHeight) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: _buildImage(imageUrls[0], maxWidth, maxHeight),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _buildImage(imageUrls[1], maxWidth, maxHeight),
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _buildImage(imageUrls[2], maxWidth, maxHeight),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFourImages(List<String> imageUrls, double maxWidth, double maxHeight) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildImage(imageUrls[0], maxWidth, maxHeight)),
                const SizedBox(width: 2),
                Expanded(child: _buildImage(imageUrls[1], maxWidth, maxHeight)),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildImage(imageUrls[2], maxWidth, maxHeight)),
                const SizedBox(width: 2),
                Expanded(child: _buildImage(imageUrls[3], maxWidth, maxHeight)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl, double maxWidth, double maxHeight) {
    return (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'))
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: maxWidth,
            height: maxHeight,
          )
        : Image.file(
            File(imageUrl),
            fit: BoxFit.cover,
            width: maxWidth,
            height: maxHeight,
          );
  }
}
