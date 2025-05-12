# Flutter PPTX Example 2

This example demonstrates how to use the `title_content_and_images` slide type from the `flutter_pptx` package.

## Setup

1. Make sure you have Flutter installed and set up on your machine.

2. Add sample images to the `assets/images/` directory:
   - `sample_jpg.jpg`
   - `sample_png.png`
   - `sample_gif.gif`

   You can use any images you like, just make sure to name them according to the paths used in the code.

3. Run the following commands:
   ```bash
   flutter pub get
   flutter run
   ```

## Features

This example creates a presentation with three slides using the `title_content_and_images` layout:

1. Project Overview - Introduces the custom slide layout
2. Key Features - Lists the advantages of the layout
3. Implementation Details - Shows technical aspects

Each slide includes:
- A title at the top
- Content on the left side
- Two images with captions on the right side

## Usage

1. Launch the app
2. Tap the "Create Presentation" button
3. The app will generate a PPTX file and open the share dialog
4. Choose how you want to share or save the presentation

## Dependencies

- flutter_pptx: Local package for PPTX generation
- path_provider: For handling file paths
- share_plus: For sharing the generated PPTX file
