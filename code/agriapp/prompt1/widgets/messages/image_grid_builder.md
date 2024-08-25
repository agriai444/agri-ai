

strings_enum.dart:
```dart

    static const String hello = 'hello';
    static const String loading = 'loading';

    static const String noInternetConnection = 'no internet connection';
    static const String serverNotResponding = 'server not responding';

```
en_us_translation.dart:
```dart

    Strings.hello : 'Hello!',
    Strings.loading : 'Loading',

    Strings.noInternetConnection : 'No internet connection!',
    Strings.serverNotResponding : 'Server is not responding!',

```
and use like Text(Strings.hello.tr)

now add translate for this code

```dart


class ImageGridBuilder {
  static Widget buildImageGrid(List<String> imageUrls) {
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

  static Widget _buildImageContent(List<String> imageUrls, double maxWidth, double maxHeight) {
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

  static Widget _buildSingleImage(String imageUrl, double maxWidth, double maxHeight) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: _buildImage(imageUrl, maxWidth, maxHeight),
      ),
    );
  }

  static Widget _buildTwoImages(List<String> imageUrls, double maxWidth, double maxHeight) {
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

  static Widget _buildThreeImages(List<String> imageUrls, double maxWidth, double maxHeight) {
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

  static Widget _buildFourImages(List<String> imageUrls, double maxWidth, double maxHeight) {
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

  static Widget _buildImage(String imageUrl, double maxWidth, double maxHeight) {
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

```

        i want answer like below formate. dont added any thing explain 
### Step 1: Update `Strings` Class

```dart
    // New keys for SplashPageView
    static const String agricultural = 'agricultural';
    static const String expert = 'expert';
    static const String companionText = 'companion_text';

```

### Step 2: Update `en_us_translation.dart`

```dart

    // Translations for SplashPageView
    Strings.agricultural : 'Agricultural',
    Strings.expert : 'Expert',
    Strings.companionText : 'Your companion for agricultural expertise',

```

### Step 3: write new code to Use Translations liks Strings.agricultural.tr

```dart



```
