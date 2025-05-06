import 'package:w2d_customer_mobile/core/utils/decode_jwt.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_hierarchy_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';

class RepositoryConv {
  static UserEntity convertVerifyOtpModelToUserEntity(VerifyOtpModel model) {
    Map<String, dynamic> parsedJson = DecodeJWT().parseJwt(model.data!.access!);
    return UserEntity(email: parsedJson['email']);
  }

  static List<ProductCategoryEntity> convertCategoriesHierarchyModelToEntity(
    CategoryHierarchyModel model,
  ) {
    return model.data
            ?.map(
              (e) => ProductCategoryEntity(
                id: -1,
                name: e.name ?? "NotAvailable",
                handle: e.handle ?? "",
                parent: -1,
                subCategories:
                    e.subcategories
                        ?.map(
                          (e) => ProductSubCategoryEntity(
                            id: -1,
                            parent: -1,
                            name: e.name ?? "NotAvailable",
                            handle: e.handle ?? "",
                          ),
                        )
                        .toList() ??
                    [],
              ),
            )
            .toList() ??
        [];
  }

  static List<ProductCategoryListingEntity> convertProductCategoryModelToEntity(
    List<ProductCategoryListModel> model,
  ) {
    return model
        .map(
          (e) => ProductCategoryListingEntity(
            id: e.id ?? "NotAvailable",
            name: e.name ?? "NotAvailable",
            sku: e.sku ?? "NotAvailable",
            productType: e.productType ?? "NotAvailable",
            regularPrice: e.regularPrice ?? "NotAvailable",
            mainImage: e.mainImage ?? "NotAvailable",
            category: ProductCategoryEntity(
              id: e.category?.id ?? -1,
              name: e.category?.name ?? "NotAvailable",
              handle: '',
              parent: e.category?.parent ?? -1,
              subCategories:
                  e.category?.subcategories
                      ?.map(
                        (e) => ProductSubCategoryEntity(
                          id: e.id ?? -1,
                          name: e.name ?? "NotAvailable",
                          handle: '',
                          parent: e.parent ?? -1,
                        ),
                      )
                      .toList() ??
                  [],
              // allowedAttributes: AllowedAttributesEntity(
              //   size: e.category?.allowedAttributes?.size ?? [],
              //   color: e.category?.allowedAttributes?.color ?? [],
              //   topNotes: e.category?.allowedAttributes?.topNotes ?? [],
              //   baseNotes: e.category?.allowedAttributes?.baseNotes ?? [],
              //   heartNotes: e.category?.allowedAttributes?.heartNotes ?? [],
              // ),
            ),
            brand: BrandEntity(
              id: e.brand?.id ?? -1,
              name: e.brand?.name ?? "NotAvailable",
            ),
            salePrice: e.salePrice ?? "NotAvailable",
            seller: SellerEntity(
              id: e.seller?.id ?? -1,
              businessName: e.seller?.businessName ?? "NotAvailable",
              isHiddenGem: e.seller?.isHiddenGem ?? true,
            ),
          ),
        )
        .toList();
  }

  static ProductViewEntity convertProductViewModelToEntity(
    ProductViewModel model,
  ) {
    return ProductViewEntity(
        id: model.data?.id ?? "",
        seller: SellerDetail(
          id: model.data?.seller?.id ?? -1,
          businessName: model.data?.seller?.businessName ?? "",
        ),
        category: ProductCategoryEntity(
          id: -1,
          parent: -1,
          name: model.data?.category?.name ?? "",
          handle: "",
          subCategories: [
            ProductSubCategoryEntity(id: -1, name: "", handle: "", parent: -1),
          ],
        ),
        brand: model.data?.brand,
        reviews: model.data?.reviews ?? [],
        variations: model.data?.variations ?? [],
        name: model.data?.name ?? "",
        sku: model.data?.sku ?? "",
        modelNumber: model.data?.modelNumber,
        productType: model.data?.productType ?? "",
        badge: model.data?.badge ?? "",
        shortDescription: model.data?.shortDescription ?? "",
        longDescription: model.data?.longDescription ?? "",
        keyFeatures: model.data?.keyFeatures,
        mainImage: model.data?.mainImage ?? "",
        gallery: model.data?.gallery ?? [],
        videoUrl: model.data?.videoUrl,
        regularPrice: model.data?.regularPrice ?? "",
        localTransitFee: model.data?.localTransitFee ?? "",
        salePrice: model.data?.salePrice ?? "",
        currency: model.data?.currency,
        availableStock: model.data?.availableStock ?? -1,
        lowStockAlert: model.data?.lowStockAlert ?? -1,
        purchaseLimit: model.data?.purchaseLimit ?? -1,
        commissionPercentage: model.data?.commissionPercentage,
        weight: model.data?.weight ?? "",
        weightUnit: model.data?.weightUnit ?? "",
        shippingWeight: model.data?.shippingWeight,
        shippingWeightUnit: model.data?.shippingWeightUnit ?? "",
        dimensions: ProductViewDimensionsEntity(
          width: DimensionValues(
            unit: model.data?.dimensions?.width?.unit ?? "",
            value: model.data?.dimensions?.width?.value ?? -1,
          ),
          height: DimensionValues(
            unit: model.data?.dimensions?.height?.unit ?? "",
            value: model.data?.dimensions?.height?.value ?? -1,
          ),
          length: DimensionValues(
            unit: model.data?.dimensions?.length?.unit ?? "",
            value: model.data?.dimensions?.length?.value ?? -1,
          ),
        ),
        packagingDimensions: ProductViewDimensionsEntity(
          width: DimensionValues(
            unit: model.data?.dimensions?.width?.unit ?? "",
            value: model.data?.dimensions?.width?.value ?? -1,
          ),
          height: DimensionValues(
            unit: model.data?.dimensions?.height?.unit ?? "",
            value: model.data?.dimensions?.height?.value ?? -1,
          ),
          length: DimensionValues(
            unit: model.data?.dimensions?.length?.unit ?? "",
            value: model.data?.dimensions?.length?.value ?? -1,
          ),
        ),
        packagingDetails:
            model.data?.packagingDetails
                ?.map(
                  (e) => ProductViewDimensionsEntity(
                    width: DimensionValues(
                      unit: model.data?.dimensions?.width?.unit ?? "",
                      value: model.data?.dimensions?.width?.value ?? -1,
                    ),
                    height: DimensionValues(
                      unit: model.data?.dimensions?.height?.unit ?? "",
                      value: model.data?.dimensions?.height?.value ?? -1,
                    ),
                    length: DimensionValues(
                      unit: model.data?.dimensions?.length?.unit ?? "",
                      value: model.data?.dimensions?.length?.value ?? -1,
                    ),
                  ),
                )
                .toList() ??
            [],
        shippingMethods: model.data?.shippingMethods ?? "",
        shippingRegion: model.data?.shippingRegion ?? "",
        shippingCountries: model.data?.shippingCountries ?? [],
        handlingTime: model.data?.handlingTime ?? "",
        returnsPolicy: model.data?.returnsPolicy,
        tags: model.data?.tags,
        seoTitle: model.data?.seoTitle,
        metaDescription: model.data?.metaDescription,
        status: model.data?.status ?? "",
        publishDate: model.data?.publishDate,
        visibility: model.data?.visibility ?? "",
        specificCustomerGroups: model.data?.specificCustomerGroups,
        lastUpdatedBy: model.data?.lastUpdatedBy,
        technicalSpecifications: {},
        hasVariant: model.data?.hasVariant ?? false,
        woodenBoxPackaging: model.data?.woodenBoxPackaging ?? false,
        isPerfume: model.data?.isPerfume ?? false,
        containsBattery: model.data?.containsBattery ?? false,
        isCosmetics: model.data?.isCosmetics ?? false,
        containsMagnet: model.data?.containsMagnet ?? false,
        countryOfOrigin: model.data?.countryOfOrigin ?? "",
        hsCode: model.data?.hsCode,
        isActive: model.data?.isActive ?? false,
        createdAt: model.data?.createdAt ?? "",
        lastUpdatedAt: model.data?.lastUpdatedAt ?? "",
      );
  }
}
