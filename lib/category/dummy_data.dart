import 'package:flutter/material.dart';
import 'package:onboarding/category/category_model.dart';
import 'package:onboarding/utils/constants/images_file.dart';

class TDummyData {
  // static final List<BannerModel> banners = [
  //   BannerModel(
  //       active: false,
  //       targetScreen: TRoutes.onBoarding,
  //       imageUrl: TImages.facebook),
  //   BannerModel(
  //       active: true, targetScreen: 'targetScreen', imageUrl: TImages.facebook),
  //   BannerModel(
  //       active: false,
  //       targetScreen: 'targetScreen',
  //       imageUrl: TImages.facebook),
  // ];

  static List<CategoryModel> categories = [
    CategoryModel(
        id: '1', name: 'Sports', image: TImages.facebook, isFeatured: true),
    CategoryModel(
        id: '2', name: 'Clothes', image: TImages.facebook, isFeatured: true),
    CategoryModel(
        id: '3', name: 'Shoes', image: TImages.facebook, isFeatured: true),
    CategoryModel(
        id: '4', name: 'Jewelery', image: TImages.facebook, isFeatured: true),
    CategoryModel(
        id: '5', name: 'Animals', image: TImages.facebook, isFeatured: true),
    CategoryModel(
        id: '6',
        name: 'Sports Shoes',
        image: TImages.facebook,
        parentId: '1',
        isFeatured: true),
    CategoryModel(
        id: '7',
        name: 'Sports Equipments',
        image: TImages.facebook,
        parentId: '1',
        isFeatured: true),
  ];
//   static final List<ProductModel> products = [
//     ProductModel(
//       id: "001",
//       title: "Green Nike sports shoe",
//       price: 135,
//       stock: 15,
//       thumbnail: TImages.product,
//       isFeatured: true,
//       description: "Green shoes",
//       brand: BrandModel(
//           id: "1",
//           image: TImages.facebook,
//           name: "Nike",
//           productsCount: 265,
//           isFeatured: true),
//       images: [TImages.deliveredEmailIllustration, TImages.pormobanner2],
//       salePrice: 30,
//       sku: "ABR4568",
//       categoryId: "1",
//       productAttributes: [
//         ProductAttributeModel(name: "Color", values: ['Green', "Black", "Red"]),
//         ProductAttributeModel(name: "Size", values: ["EU56", "EU34"]),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: "1",
//             stock: 34,
//             price: 134,
//             salePrice: 122.65,
//             image: TImages.product,
//             description: "This shoes ic very much comfortable.",
//             attributeValues: {"Color": "Green", "Size": "EU56"}),
//         ProductVariationModel(
//             id: "2",
//             stock: 15,
//             price: 133,
//             salePrice: 129,
//             image: TImages.product,
//             description: "This shoes ic very much comfortable.",
//             attributeValues: {"Color": "Green", "Size": "EU34"}),
//       ],
//       productType: "ProductType.variable",
//     ),
//     ProductModel(
//       id: "002",
//       title: "Black Adidas Running Shoes",
//       price: 145,
//       stock: 20,
//       thumbnail: TImages.product,
//       isFeatured: false,
//       description: "Sleek black running shoes from Adidas.",
//       brand: BrandModel(
//           id: "2",
//           image: TImages.product,
//           name: "Adidas",
//           productsCount: 300,
//           isFeatured: false),
//       images: [TImages.product, TImages.product],
//       salePrice: 130,
//       sku: "XYZ789",
//       categoryId: "2",
//       productAttributes: [
//         ProductAttributeModel(name: "Color", values: ['Black', "White"]),
//         ProductAttributeModel(name: "Size", values: ["EU40", "EU42", "EU44"]),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: "3",
//             stock: 25,
//             price: 140,
//             salePrice: 135,
//             image: TImages.product,
//             description: "Ideal for runners",
//             attributeValues: {"Color": "Black", "Size": "EU40"}),
//         ProductVariationModel(
//             id: "4",
//             stock: 10,
//             price: 145,
//             salePrice: 140,
//             image: TImages.product,
//             description: "Lightweight design",
//             attributeValues: {"Color": "White", "Size": "EU42"}),
//       ],
//       productType: 'ProductType.variable',
//     ),
//     ProductModel(
//       id: "003",
//       title: "Puma Casual Sneakers",
//       price: 110,
//       stock: 30,
//       thumbnail: TImages.product,
//       isFeatured: true,
//       description: "Trendy casual sneakers from Puma.",
//       brand: BrandModel(
//           id: "3",
//           image: TImages.product,
//           name: "Puma",
//           productsCount: 200,
//           isFeatured: true),
//       images: [TImages.product, TImages.product],
//       salePrice: 100,
//       sku: "LMN123",
//       categoryId: "3",
//       productAttributes: [
//         ProductAttributeModel(name: "Color", values: ['Blue', "Grey"]),
//         ProductAttributeModel(name: "Size", values: ["EU38", "EU40", "EU42"]),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: "5",
//             stock: 20,
//             price: 110,
//             salePrice: 105,
//             image: TImages.product,
//             description: "Perfect for daily wear",
//             attributeValues: {"Color": "Blue", "Size": "EU38"}),
//         ProductVariationModel(
//             id: "6",
//             stock: 15,
//             price: 115,
//             salePrice: 110,
//             image: TImages.product,
//             description: "Premium build quality",
//             attributeValues: {"Color": "Grey", "Size": "EU42"}),
//       ],
//       productType: 'ProductType.variable',
//     ),
//     ProductModel(
//       id: "004",
//       title: "Reebok Training Shoes",
//       price: 125,
//       stock: 18,
//       thumbnail: TImages.product,
//       isFeatured: false,
//       description: "Durable training shoes from Reebok.",
//       brand: BrandModel(
//           id: "4",
//           image: TImages.product,
//           name: "Reebok",
//           productsCount: 150,
//           isFeatured: false),
//       images: [TImages.product, TImages.product],
//       salePrice: 115,
//       sku: "DEF456",
//       categoryId: "4",
//       productAttributes: [
//         ProductAttributeModel(
//             name: "Color", values: ['White', "Grey", "Black"]),
//         ProductAttributeModel(name: "Size", values: ["EU40", "EU42", "EU44"]),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: "7",
//             stock: 22,
//             price: 125,
//             salePrice: 118,
//             image: TImages.product,
//             description: "Built for performance",
//             attributeValues: {"Color": "White", "Size": "EU40"}),
//         ProductVariationModel(
//             id: "8",
//             stock: 10,
//             price: 130,
//             salePrice: 125,
//             image: TImages.product,
//             description: "Enhanced grip",
//             attributeValues: {"Color": "Black", "Size": "EU44"}),
//       ],
//       productType: 'ProductType.variable',
//     ),
//   ];
}
