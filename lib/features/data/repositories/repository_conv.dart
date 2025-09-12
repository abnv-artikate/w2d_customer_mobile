import 'package:w2d_customer_mobile/core/utils/decode_jwt.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/updated_cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/collections_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/data/model/search/search_result_autocomplete_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/calculate_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/confirm_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/freight_quote_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/select_freight_service_model.dart';
import 'package:w2d_customer_mobile/features/data/model/telr_payment/telr_payment_response_model.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/updated_cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/search/search_result_autocomplete_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/confirm_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/select_freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';

class RepositoryConv {
  static UserEntity convertVerifyOtpModelToUserEntity(VerifyOtpModel model) {
    Map<String, dynamic> parsedJson = DecodeJWT().parseJwt(model.data!.access!);
    return UserEntity(
      email: parsedJson['email'],
      fullName: parsedJson['full_name'],
      store: parsedJson['store'],
      authKey: parsedJson['authkey'],
    );
  }

  static List<SubCategoriesEntity> convertCategoriesHierarchyModelToEntity(
    CategoriesModel model,
  ) {
    return model.data
            ?.map(
              (e) => SubCategoriesEntity(
                name: e.name ?? "",
                handle: e.handle ?? "",
                image: e.image ?? "",
                subcategories:
                    e.subcategories
                        ?.map(
                          (e) => SubCategoriesEntity(
                            name: e.name ?? "",
                            handle: e.handle ?? "",
                            image: e.image ?? "",
                            subcategories:
                                e.subcategories
                                    ?.map(
                                      (e) => SubCategoriesEntity(
                                        name: e.name ?? "",
                                        handle: e.handle ?? "",
                                        image: e.image ?? "",
                                        subcategories: [],
                                      ),
                                    )
                                    .toList() ??
                                [],
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
                (e) => CategoryProductEntity(
                  id: e.id ?? "",
                  productName: e.name ?? "",
                  sku: e.sku ?? "",
                  productType: e.productType ?? "",
                  regularPrice: e.regularPrice ?? "",
                  mainImage: e.mainImage ?? "",
                  category: SubCategoriesEntity(
                    name: e.category?.name ?? "",
                    handle: "",
                    image: "",
                    subcategories: [],
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

  static CollectionsEntity convertCollectionsModelToEntity(
    CollectionsModel model,
  ) {
    return CollectionsEntity(
      count: model.count ?? -1,
      next: model.next,
      previous: model.previous,
      results: CollectionsResultEntity(
        status: model.results?.status ?? "",
        message: model.results?.message ?? "",
        data:
            model.results?.data
                ?.map(
                  (e) => CollectionsResultDataEntity(
                    id: e.id ?? "",
                    products:
                        e.products
                            ?.map(
                              (e) => CollectionsResultDataProductEntity(
                                id: e.id ?? "",
                                reviews: e.reviews ?? [],
                                name: e.name ?? "",
                                sku: e.sku ?? "",
                                modelNumber: e.modelNumber ?? "",
                                productType: e.productType ?? "",
                                badge: e.badge ?? "",
                                shortDescription: e.shortDescription ?? "",
                                longDescription: e.longDescription ?? "",
                                keyFeatures: e.keyFeatures,
                                mainImage: e.mainImage ?? "",
                                gallery: e.gallery ?? [],
                                videoUrl: e.videoUrl,
                                regularPrice: e.regularPrice ?? "",
                                localTransitFee: e.localTransitFee ?? "",
                                salePrice: e.salePrice ?? "",
                                currency: e.currency,
                                availableStock: e.availableStock ?? -1,
                                lowStockAlert: e.lowStockAlert ?? -1,
                                purchaseLimit: e.purchaseLimit ?? -1,
                                commissionPercentage:
                                    e.commissionPercentage ?? "",
                                weight: e.weight ?? "",
                                weightUnit: e.weightUnit ?? "",
                                shippingWeight: e.shippingWeight,
                                shippingWeightUnit: e.shippingWeightUnit ?? "",
                                shippingMethods: e.shippingMethods ?? "",
                                shippingRegion: e.shippingRegion ?? "",
                                shippingCountries: e.shippingCountries ?? [],
                                handlingTime: e.handlingTime ?? "",
                                returnsPolicy: e.returnsPolicy ?? "",
                                tags: e.tags ?? "",
                                seoTitle: e.seoTitle,
                                metaDescription: e.metaDescription ?? "",
                                status: e.status ?? "",
                                publishDate: e.publishDate,
                                visibility: e.visibility ?? "",
                                specificCustomerGroups:
                                    e.specificCustomerGroups,
                                lastUpdatedBy: e.lastUpdatedBy ?? false,
                                hasVariant: e.hasVariant ?? false,
                                woodenBoxPackaging:
                                    e.woodenBoxPackaging ?? false,
                                isPerfume: e.isPerfume ?? false,
                                containsBattery: e.containsBattery ?? false,
                                isCosmetics: e.isCosmetics ?? false,
                                containsMagnet: e.containsMagnet ?? false,
                                countryOfOrigin: e.countryOfOrigin ?? "",
                                hsCode: e.hsCode ?? "",
                                isActive: e.isActive ?? false,
                                createdAt: e.createdAt ?? "",
                                lastUpdatedAt: e.lastUpdatedAt ?? "",
                              ),
                            )
                            .toList() ??
                        [],
                    name: e.name ?? "",
                    slug: e.slug ?? "",
                    collectionType: e.collectionType ?? "",
                    description: e.description ?? "",
                    backgroundImage: e.backgroundImage ?? "",
                    isActive: e.isActive ?? false,
                    createdAt: e.createdAt ?? "",
                    updatedAt: e.updatedAt ?? "",
                  ),
                )
                .toList() ??
            [],
      ),
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
      category: SubCategoriesEntity(
        name: model.data?.category?.name ?? "",
        handle: "",
        image: "",
        subcategories: [],
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

  static UpdatedCartEntity convertUpdateCartModelToEntity(
    UpdatedCartModel model,
  ) {
    return UpdatedCartEntity(
      status: model.status ?? "",
      message: model.message ?? "",
      cartData: UpdatedCartData(
        id: model.cartData?.id ?? -1,
        customer: model.cartData?.customer,
        sessionKey: model.cartData?.sessionKey ?? "",
        createdAt: model.cartData?.createdAt ?? "",
      ),
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
        goodsValue: model.data?.goodsValue,
        freightAmount: model.data?.freightAmount,
        insuranceAmt: model.data?.insuranceAmt,
        totalDutyTax: model.data?.totalDutyTax,
        netTotal: model.data?.netTotal,
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

  static SearchResultAutoCompleteEntity convertSearchResultModelToEntity(
    SearchResultAutoCompleteModel model,
  ) {
    return SearchResultAutoCompleteEntity(
      status: model.status,
      productSuggestions:
          model.products
              .map(
                (e) => SuggestionClassEntity(
                  id: e.id,
                  name: e.name,
                  sku: e.sku,
                  mainImage: e.mainImage,
                ),
              )
              .toList(),
      searchTerms: model.searchTerms,
      categoryName: model.categoryName,
    );
  }

  static PaymentResponseEntity convertTelrPaymentResponseToEntity(
    TelrPaymentResponseModel model,
  ) {
    return PaymentResponseEntity(
      startUrl: model.startUrl,
      closeUrl: model.closeUrl,
      abortUrl: model.abortUrl,
      transactionCode: model.code,
    );
  }
}
