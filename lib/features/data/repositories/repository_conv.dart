import 'package:w2d_customer_mobile/core/utils/decode_jwt.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_hierarchy_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/calculate_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/confirm_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/freight_quote_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/select_freight_service_model.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/confirm_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/select_freight_quote_entity.dart';
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

  static ProductCategoryListingEntity convertProductCategoryModelToEntity(
    ProductCategoryListModel model,
  ) {
    return ProductCategoryListingEntity(
      count: model.count ?? -1,
      next: model.next ?? "",
      previous: model.previous,
      results:
          model.results
              ?.map(
                (e) => ResultEntity(
                  id: e.id ?? "",
                  productName: e.name ?? "",
                  sku: e.sku ?? "",
                  productType: e.productType ?? "",
                  regularPrice: e.regularPrice ?? "",
                  mainImage: e.mainImage ?? "",
                  category: ProductCategoryEntity(
                    id: e.category?.id ?? -1,
                    name: e.category?.name ?? "",
                    handle: "",
                    parent: -1,
                    subCategories: [],
                  ),
                  brand: BrandEntity(
                    id: e.brand?.id ?? -1,
                    name: e.brand?.name ?? "",
                  ),
                  salePrice: e.salePrice ?? "",
                  reviews: e.reviews ?? [],
                  seller: SellerEntity(
                    id: e.seller?.id ?? -1,
                    businessName: e.seller?.businessName ?? "",
                    isHiddenGem: e.seller?.isHiddenGem ?? true,
                  ),
                ),
              )
              .toList() ??
          [],
    );
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

  static CartEntity convertCartModelToEntity(CartModel model) {
    return CartEntity(
      id: model.data?.id ?? -1,
      customer: model.data?.customer,
      sessionKey: model.data?.sessionKey ?? "",
      createdAt: model.data?.createdAt ?? "",
      items:
          model.data?.items
              ?.map(
                (e) => CartItemEntity(
                  id: e.id ?? -1,
                  cart: e.cart ?? -1,
                  quantity: e.quantity ?? -1,
                  voucherCode: e.voucherCode,
                  discountAmount: e.discountAmount ?? "",
                  addedAt: e.addedAt ?? "",
                  isChecked: e.isChecked ?? true,
                  product: ProductEntity(
                    id: e.product?.id ?? "",
                    name: e.product?.name ?? "",
                    sku: e.product?.sku ?? "",
                    modelNumber: e.product?.modelNumber,
                    productType: e.product?.productType ?? "",
                    badge: e.product?.badge ?? "",
                    shortDescription: e.product?.shortDescription ?? "",
                    longDescription: e.product?.longDescription ?? "",
                    keyFeatures: e.product?.keyFeatures ?? "",
                    mainImage: e.product?.mainImage ?? "",
                    gallery: e.product?.gallery ?? [],
                    videoUrl: e.product?.videoUrl ?? "",
                    regularPrice: e.product?.regularPrice ?? "",
                    localTransitFee: e.product?.localTransitFee ?? "",
                    salePrice: e.product?.salePrice ?? "",
                    currency: e.product?.currency,
                    availableStock: e.product?.availableStock ?? -1,
                    lowStockAlert: e.product?.lowStockAlert ?? 1,
                    purchaseLimit: e.product?.purchaseLimit ?? -1,
                    commissionPercentage: e.product?.commissionPercentage,
                    weight: e.product?.weight ?? "",
                    weightUnit: e.product?.weightUnit ?? "",
                    shippingWeight: e.product?.shippingWeight,
                    shippingWeightUnit: e.product?.shippingWeightUnit ?? "",
                    dimensions: ProductDimensions(
                      width: DimensionEntity(
                        unit: e.product?.dimensions?.width?.unit ?? "",
                        value: e.product?.dimensions?.width?.value ?? "",
                      ),
                      height: DimensionEntity(
                        unit: e.product?.dimensions?.height?.unit ?? "",
                        value: e.product?.dimensions?.height?.value ?? "",
                      ),
                      length: DimensionEntity(
                        unit: e.product?.dimensions?.length?.unit ?? "",
                        value: e.product?.dimensions?.length?.value ?? "",
                      ),
                      weight: DimensionEntity(
                        unit: e.product?.dimensions?.weight?.unit ?? "",
                        value: e.product?.dimensions?.weight?.value ?? "",
                      ),
                    ),
                    packagingDimensions: ProductDimensions(
                      width: DimensionEntity(
                        unit: e.product?.dimensions?.width?.unit ?? "",
                        value: e.product?.dimensions?.width?.value ?? "",
                      ),
                      height: DimensionEntity(
                        unit: e.product?.dimensions?.height?.unit ?? "",
                        value: e.product?.dimensions?.height?.value ?? "",
                      ),
                      length: DimensionEntity(
                        unit: e.product?.dimensions?.length?.unit ?? "",
                        value: e.product?.dimensions?.length?.value ?? "",
                      ),
                      weight: DimensionEntity(
                        unit: e.product?.dimensions?.weight?.unit ?? "",
                        value: e.product?.dimensions?.weight?.value ?? "",
                      ),
                    ),
                    packagingDetails:
                        e.product?.packagingDetails
                            ?.map(
                              (e) => ProductDimensions(
                                width: DimensionEntity(
                                  unit: e.width?.unit ?? "",
                                  value: e.width?.value ?? "",
                                ),
                                height: DimensionEntity(
                                  unit: e.height?.unit ?? "",
                                  value: e.height?.value ?? "",
                                ),
                                length: DimensionEntity(
                                  unit: e.length?.unit ?? "",
                                  value: e.length?.value ?? "",
                                ),
                                weight: DimensionEntity(
                                  unit: e.weight?.unit ?? "",
                                  value: e.weight?.value ?? "",
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                    shippingMethods: e.product?.shippingMethods ?? "",
                    shippingRegion: e.product?.shippingRegion ?? "",
                    shippingCountries: e.product?.shippingCountries ?? [],
                    handlingTime: e.product?.handlingTime ?? "",
                    returnsPolicy: e.product?.returnsPolicy,
                    tags: e.product?.tags,
                    seoTitle: e.product?.seoTitle,
                    metaDescription: e.product?.metaDescription,
                    status: e.product?.status ?? "",
                    publishDate: e.product?.publishDate,
                    visibility: e.product?.visibility ?? "",
                    specificCustomerGroups: e.product?.specificCustomerGroups,
                    lastUpdatedBy: e.product?.lastUpdatedBy,
                    technicalSpecifications: e.product?.technicalSpecifications,
                    hasVariant: e.product?.hasVariant ?? false,
                    woodenBoxPackaging: e.product?.woodenBoxPackaging ?? false,
                    isPerfume: e.product?.isPerfume ?? false,
                    containsBattery: e.product?.containsBattery ?? false,
                    isCosmetics: e.product?.isCosmetics ?? false,
                    containsMagnet: e.product?.containsMagnet ?? false,
                    countryOfOrigin: e.product?.countryOfOrigin ?? "",
                    hsCode: e.product?.hsCode,
                    isActive: e.product?.isActive ?? false,
                    createdAt: e.product?.createdAt ?? "",
                    lastUpdatedAt: e.product?.lastUpdatedAt ?? "",
                    seller: e.product?.seller ?? -1,
                    brand: e.product?.brand ?? -1,
                  ),
                ),
              )
              .toList() ??
          [],
    );
  }

  static CalculateInsuranceEntity convertCalculateInsuranceModelToEntity(
    CalculateInsuranceModel model,
  ) {
    return CalculateInsuranceEntity(
      code: model.code ?? -1,
      status: model.status ?? false,
      info: model.info ?? "",
      message: model.message ?? "",
      data: CalculateInsuranceEntityData(
        goodsValue: model.data?.goodsValue ?? -1,
        freightAmount: model.data?.freightAmount ?? -1,
        insuranceAmt: model.data?.insuranceAmt ?? -1,
        totalDutyTax: model.data?.totalDutyTax ?? "",
        netTotal: model.data?.netTotal ?? -1,
      ),
    );
  }

  static ConfirmInsuranceEntity convertConfirmInsuranceModelToEntity(
    ConfirmInsuranceModel model,
  ) {
    return ConfirmInsuranceEntity(
      code: model.code ?? -1,
      status: model.status ?? false,
      info: model.info ?? "",
      message: model.message ?? "",
      data: ConfirmInsuranceEntityData(
        freightAmount: model.data?.freightAmount ?? -1,
        insuranceAmt: model.data?.insuranceAmt ?? -1,
        totalDutyTax: model.data?.totalDutyTax ?? "",
        netTotal: model.data?.netTotal ?? -1,
      ),
    );
  }

  static SelectFreightServiceEntity convertSelectFreightServiceModelToEntity(
    SelectFreightServiceModel model,
  ) {
    return SelectFreightServiceEntity(
      code: model.code ?? -1,
      status: model.status ?? false,
      info: model.info ?? "",
      message: model.message ?? "",
      data: SelectFreightQuoteEntityData(amount: model.data?.amount ?? -1),
    );
  }

  static FreightQuoteEntity convertGetFreightQuoteModelToEntity(
    FreightQuoteModel model,
  ) {
    return FreightQuoteEntity(
      code: model.code ?? -1,
      status: model.status ?? false,
      info: model.info ?? "",
      message: model.message ?? "",
      data: FreightQuoteEntityData(
        quoteToken: model.data?.quoteToken ?? "",
        quoteAir: QuoteEntity(
          portDelivery: TentacledPortDeliveryEntity(
            message: model.data?.quoteAir?.portDelivery?.message ?? "",
            totalAmount: model.data?.quoteAir?.portDelivery?.totalAmount ?? -1,
            totalDutyTax:
                model.data?.quoteAir?.portDelivery?.totalDutyTax ?? "",
            portGrantTotal:
                model.data?.quoteAir?.portDelivery?.portGrantTotal ?? -1,
            portDeliveryTt:
                model.data?.quoteAir?.portDelivery?.portDeliveryTt ?? -1,
          ),
          doorDelivery: IndigoDoorDeliveryEntity(
            message: model.data?.quoteAir?.doorDelivery?.message ?? "",
            totalAmount: model.data?.quoteAir?.doorDelivery?.totalAmount ?? -1,
            totalDutyTax:
                model.data?.quoteAir?.doorDelivery?.totalDutyTax ?? "",
            doorGrantTotal:
                model.data?.quoteAir?.doorDelivery?.doorGrantTotal ?? -1,
            doorDeliveryTt:
                model.data?.quoteAir?.doorDelivery?.doorDeliveryTt ?? -1,
          ),
        ),
        quoteSea: QuoteEntity(
          portDelivery: TentacledPortDeliveryEntity(
            message: model.data?.quoteSea?.portDelivery?.message ?? "",
            totalAmount: model.data?.quoteSea?.portDelivery?.totalAmount ?? -1,
            totalDutyTax:
                model.data?.quoteSea?.portDelivery?.totalDutyTax ?? "",
            portGrantTotal:
                model.data?.quoteSea?.portDelivery?.portGrantTotal ?? -1,
            portDeliveryTt:
                model.data?.quoteSea?.portDelivery?.portDeliveryTt ?? -1,
          ),
          doorDelivery: IndigoDoorDeliveryEntity(
            message: model.data?.quoteSea?.doorDelivery?.message ?? "",
            totalAmount: model.data?.quoteSea?.doorDelivery?.totalAmount ?? -1,
            totalDutyTax:
                model.data?.quoteSea?.doorDelivery?.totalDutyTax ?? "",
            doorGrantTotal:
                model.data?.quoteSea?.doorDelivery?.doorGrantTotal ?? -1,
            doorDeliveryTt:
                model.data?.quoteSea?.doorDelivery?.doorDeliveryTt ?? -1,
          ),
        ),
        quoteCourier: DataQuoteCourierEntity(
          doorDelivery: IndecentDoorDeliveryEntity(
            doorDeliveryTt:
                model.data?.quoteCourier?.doorDelivery?.doorDeliveryTt ?? "",
            message: model.data?.quoteCourier?.doorDelivery?.message ?? "",
            totalAmount:
                model.data?.quoteCourier?.doorDelivery?.totalAmount ?? -1,
            totalDutyTax:
                model.data?.quoteCourier?.doorDelivery?.totalDutyTax ?? "",
            doorGrantTotal:
                model.data?.quoteCourier?.doorDelivery?.doorGrantTotal ?? -1,
          ),
        ),
        quoteLand: DataQuoteLandEntity(
          doorDelivery: IndigoDoorDeliveryEntity(
            message: model.data?.quoteLand?.doorDelivery?.message ?? "",
            totalAmount: model.data?.quoteLand?.doorDelivery?.totalAmount ?? -1,
            totalDutyTax:
                model.data?.quoteLand?.doorDelivery?.totalDutyTax ?? "",
            doorGrantTotal:
                model.data?.quoteLand?.doorDelivery?.doorGrantTotal ?? -1,
            doorDeliveryTt:
                model.data?.quoteLand?.doorDelivery?.doorDeliveryTt ?? -1,
          ),
        ),
      ),
    );
  }
}
