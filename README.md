# amazon-orders-collage

Creates a collage (grid) of product images for each product in an amazon.com order history report.

## How to use

1. Get an [order history report](https://www.amazon.com/gp/b2b/reports) from your Amazon account
1. Clone this repo
1. Create a directory `/data` and save your order history report csv in it

    ```sh
    mkdir -p data tmp output
    ```

1. Build the Docker image.

    ```sh
    docker build -t amazon-orders-collage .
    ```

1. Download product images. Images will be saved in `/tmp`.

    ```sh
    docker run -it --rm -v $PWD/data:/usr/src/app/data -v $PWD/tmp:/usr/src/app/tmp amazon-orders-collage get-photos.js {path-to-your-csv}
    ```

1. Assemble your collage!

    ```sh
    docker run -it --rm -v $PWD/tmp:/usr/src/app/tmp -v $PWD/output:/usr/src/app/output amazon-orders-collage assemble-collage.js
    ```

1. Your collage will be saved in `/output/amazon-collage.jpg`

## Customizing Dimensions

You can customize the following layout properties in `assemble-collage.js`:

- `gridWidth` - the number of columns in the collage
- `cellPadding` - the padding around each product image (pixels)
- `imageDimension` - the dimensions (square) of the product images
- `outputPadding` - the padding around the outside of the collage (pixels)

## How it works

`get-photos.js` parses the csv, pulling the `ASIN/ISBN` value for each product.  It then GETs the product's page from amazon.com, parses the html with cheerio, grabs the first product image and saves it in `/tmp`

`assemble-collage.js` checks the number of images in `/tmp` and creates an empty white jpeg with dimensions that will fit all of the product images.  It then merges each product image with the collage, calculating the correct x/y position for each image.
