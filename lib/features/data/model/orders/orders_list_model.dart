import 'dart:convert';

class OrderListModel {
  int? count;
  dynamic next;
  dynamic previous;
  Results? results;

  OrderListModel({this.count, this.next, this.previous, this.results});

  factory OrderListModel.fromRawJson(String str) =>
      OrderListModel.fromJson(json.decode(str));

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
  );
}

class Results {
  String? status;
  String? message;
  List<Datum>? data;

  Results({this.status, this.message, this.data});

  factory Results.fromRawJson(String str) => Results.fromJson(json.decode(str));

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    status: json["status"],
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  String? id;
  String? readableId;
  dynamic original;
  Seller? seller;
  Customer? customer;
  String? customerEmail;
  String? status;
  String? chargeStatus;
  dynamic billingAddress;
  ShippingAddress? shippingAddress;
  dynamic shippingTaxRate;
  dynamic shippingTaxClass;
  dynamic shippingTaxClassName;
  String? currency;
  String? shippingPriceNetAmount;
  String? subtotal;
  String? total;
  String? platformFee;
  String? destinationDuty;
  String? vat;
  String? transitInsurance;
  String? localTransitFee;
  String? invoiceNumber;
  bool? displayGrossPrices;
  String? customerNote;
  dynamic redirectUrl;
  String? searchDocument;
  dynamic searchVector;
  String? createdAt;
  String? updatedAt;
  dynamic expiredAt;
  List<DatumItem>? items;
  List<DatumParent>? parent;

  Datum({
    this.id,
    this.readableId,
    this.original,
    this.seller,
    this.customer,
    this.customerEmail,
    this.status,
    this.chargeStatus,
    this.billingAddress,
    this.shippingAddress,
    this.shippingTaxRate,
    this.shippingTaxClass,
    this.shippingTaxClassName,
    this.currency,
    this.shippingPriceNetAmount,
    this.subtotal,
    this.total,
    this.platformFee,
    this.destinationDuty,
    this.vat,
    this.transitInsurance,
    this.localTransitFee,
    this.invoiceNumber,
    this.displayGrossPrices,
    this.customerNote,
    this.redirectUrl,
    this.searchDocument,
    this.searchVector,
    this.createdAt,
    this.updatedAt,
    this.expiredAt,
    this.items,
    this.parent,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    readableId: json["readable_id"],
    original: json["original"],
    seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    customer:
        json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    customerEmail: json["customer_email"],
    status: json["status"],
    chargeStatus: json["charge_status"],
    billingAddress: json["billing_address"],
    shippingAddress:
        json["shipping_address"] == null
            ? null
            : ShippingAddress.fromJson(json["shipping_address"]),
    shippingTaxRate: json["shipping_tax_rate"],
    shippingTaxClass: json["shipping_tax_class"],
    shippingTaxClassName: json["shipping_tax_class_name"],
    currency: json["currency"],
    shippingPriceNetAmount: json["shipping_price_net_amount"],
    subtotal: json["subtotal"],
    total: json["total"],
    platformFee: json["platform_fee"],
    destinationDuty: json["destination_duty"],
    vat: json["vat"],
    transitInsurance: json["transit_insurance"],
    localTransitFee: json["local_transit_fee"],
    invoiceNumber: json["invoice_number"],
    displayGrossPrices: json["display_gross_prices"],
    customerNote: json["customer_note"],
    redirectUrl: json["redirect_url"],
    searchDocument: json["search_document"],
    searchVector: json["search_vector"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    expiredAt: json["expired_at"],
    items:
        json["items"] == null
            ? []
            : List<DatumItem>.from(
              json["items"]!.map((x) => DatumItem.fromJson(x)),
            ),
    parent:
        json["parent"] == null
            ? []
            : List<DatumParent>.from(
              json["parent"]!.map((x) => DatumParent.fromJson(x)),
            ),
  );
}

class Customer {
  String? email;
  String? fullName;
  dynamic mobileNumber;
  dynamic secondaryMobileNumber;
  String? country;

  Customer({
    this.email,
    this.fullName,
    this.mobileNumber,
    this.secondaryMobileNumber,
    this.country,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    email: json["email"],
    fullName: json["full_name"],
    mobileNumber: json["mobile_number"],
    secondaryMobileNumber: json["secondary_mobile_number"],
    country: json["country"],
  );
}

class DatumItem {
  String? id;
  ItemOrder? order;
  bool? isReturned;
  String? readableId;
  String? status;
  dynamic currency;
  Product? product;
  Variant? variant;
  String? productName;
  String? variantName;
  String? translatedProductName;
  String? translatedVariantName;
  int? quantity;
  String? unitDiscountAmount;
  String? unitPrice;
  String? totalPrice;
  String? taxRate;
  dynamic taxClass;
  String? taxClassName;
  bool? isPriceOverridden;
  dynamic voucherCode;
  String? saleId;
  String? updatedAt;

  DatumItem({
    this.id,
    this.order,
    this.isReturned,
    this.readableId,
    this.status,
    this.currency,
    this.product,
    this.variant,
    this.productName,
    this.variantName,
    this.translatedProductName,
    this.translatedVariantName,
    this.quantity,
    this.unitDiscountAmount,
    this.unitPrice,
    this.totalPrice,
    this.taxRate,
    this.taxClass,
    this.taxClassName,
    this.isPriceOverridden,
    this.voucherCode,
    this.saleId,
    this.updatedAt,
  });

  factory DatumItem.fromRawJson(String str) =>
      DatumItem.fromJson(json.decode(str));

  factory DatumItem.fromJson(Map<String, dynamic> json) => DatumItem(
    id: json["id"],
    order: json["order"] == null ? null : ItemOrder.fromJson(json["order"]),
    isReturned: json["is_returned"],
    readableId: json["readable_id"],
    status: json["status"],
    currency: json["currency"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    variant: json["variant"] == null ? null : Variant.fromJson(json["variant"]),
    productName: json["product_name"],
    variantName: json["variant_name"],
    translatedProductName: json["translated_product_name"],
    translatedVariantName: json["translated_variant_name"],
    quantity: json["quantity"],
    unitDiscountAmount: json["unit_discount_amount"],
    unitPrice: json["unit_price"],
    totalPrice: json["total_price"],
    taxRate: json["tax_rate"],
    taxClass: json["tax_class"],
    taxClassName: json["tax_class_name"],
    isPriceOverridden: json["is_price_overridden"],
    voucherCode: json["voucher_code"],
    saleId: json["sale_id"],
    updatedAt: json["updated_at"],
  );
}

class ItemOrder {
  String? id;
  dynamic original;
  List<OrderParent>? parent;
  int? seller;
  Customer? customer;
  String? readableId;
  String? customerEmail;
  String? status;
  String? chargeStatus;
  dynamic billingAddress;
  ShippingAddress? shippingAddress;
  dynamic shippingTaxRate;
  dynamic shippingTaxClass;
  dynamic shippingTaxClassName;
  String? currency;
  String? shippingPriceNetAmount;
  String? subtotal;
  String? total;
  bool? displayGrossPrices;
  String? customerNote;
  dynamic redirectUrl;
  String? searchDocument;
  dynamic searchVector;
  String? createdAt;
  String? updatedAt;
  dynamic expiredAt;
  List<OrderItem>? items;

  ItemOrder({
    this.id,
    this.original,
    this.parent,
    this.seller,
    this.customer,
    this.readableId,
    this.customerEmail,
    this.status,
    this.chargeStatus,
    this.billingAddress,
    this.shippingAddress,
    this.shippingTaxRate,
    this.shippingTaxClass,
    this.shippingTaxClassName,
    this.currency,
    this.shippingPriceNetAmount,
    this.subtotal,
    this.total,
    this.displayGrossPrices,
    this.customerNote,
    this.redirectUrl,
    this.searchDocument,
    this.searchVector,
    this.createdAt,
    this.updatedAt,
    this.expiredAt,
    this.items,
  });

  factory ItemOrder.fromRawJson(String str) =>
      ItemOrder.fromJson(json.decode(str));

  factory ItemOrder.fromJson(Map<String, dynamic> json) => ItemOrder(
    id: json["id"],
    original: json["original"],
    parent:
        json["parent"] == null
            ? []
            : List<OrderParent>.from(
              json["parent"]!.map((x) => OrderParent.fromJson(x)),
            ),
    seller: json["seller"],
    customer:
        json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    readableId: json["readable_id"],
    customerEmail: json["customer_email"],
    status: json["status"],
    chargeStatus: json["charge_status"],
    billingAddress: json["billing_address"],
    shippingAddress:
        json["shipping_address"] == null
            ? null
            : ShippingAddress.fromJson(json["shipping_address"]),
    shippingTaxRate: json["shipping_tax_rate"],
    shippingTaxClass: json["shipping_tax_class"],
    shippingTaxClassName: json["shipping_tax_class_name"],
    currency: json["currency"],
    shippingPriceNetAmount: json["shipping_price_net_amount"],
    subtotal: json["subtotal"],
    total: json["total"],
    displayGrossPrices: json["display_gross_prices"],
    customerNote: json["customer_note"],
    redirectUrl: json["redirect_url"],
    searchDocument: json["search_document"],
    searchVector: json["search_vector"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    expiredAt: json["expired_at"],
    items:
        json["items"] == null
            ? []
            : List<OrderItem>.from(
              json["items"]!.map((x) => OrderItem.fromJson(x)),
            ),
  );
}

class OrderItem {
  String? id;
  String? readableId;
  String? order;
  String? status;
  dynamic currency;
  String? product;
  dynamic variant;
  String? productName;
  String? variantName;
  String? translatedProductName;
  String? translatedVariantName;
  int? quantity;
  String? unitDiscountAmount;
  String? unitPrice;
  String? totalPrice;
  String? taxRate;
  dynamic taxClass;
  String? taxClassName;
  bool? isPriceOverridden;
  dynamic voucherCode;
  String? saleId;
  String? updatedAt;
  bool? isReturned;

  OrderItem({
    this.id,
    this.readableId,
    this.order,
    this.status,
    this.currency,
    this.product,
    this.variant,
    this.productName,
    this.variantName,
    this.translatedProductName,
    this.translatedVariantName,
    this.quantity,
    this.unitDiscountAmount,
    this.unitPrice,
    this.totalPrice,
    this.taxRate,
    this.taxClass,
    this.taxClassName,
    this.isPriceOverridden,
    this.voucherCode,
    this.saleId,
    this.updatedAt,
    this.isReturned,
  });

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    readableId: json["readable_id"],
    order: json["order"],
    status: json["status"],
    currency: json["currency"],
    product: json["product"],
    variant: json["variant"],
    productName: json["product_name"],
    variantName: json["variant_name"],
    translatedProductName: json["translated_product_name"],
    translatedVariantName: json["translated_variant_name"],
    quantity: json["quantity"],
    unitDiscountAmount: json["unit_discount_amount"],
    unitPrice: json["unit_price"],
    totalPrice: json["total_price"],
    taxRate: json["tax_rate"],
    taxClass: json["tax_class"],
    taxClassName: json["tax_class_name"],
    isPriceOverridden: json["is_price_overridden"],
    voucherCode: json["voucher_code"],
    saleId: json["sale_id"],
    updatedAt: json["updated_at"],
    isReturned: json["is_returned"],
  );
}

class OrderParent {
  String? readableId;
  String? shippingJobToken;
  String? shippingPriceNetAmount;
  String? subtotal;
  String? total;
  String? platformFee;
  String? destinationDuty;
  String? vat;
  String? transitInsurance;
  List<String>? orders;

  OrderParent({
    this.readableId,
    this.shippingJobToken,
    this.shippingPriceNetAmount,
    this.subtotal,
    this.total,
    this.platformFee,
    this.destinationDuty,
    this.vat,
    this.transitInsurance,
    this.orders,
  });

  factory OrderParent.fromRawJson(String str) =>
      OrderParent.fromJson(json.decode(str));

  factory OrderParent.fromJson(Map<String, dynamic> json) => OrderParent(
    readableId: json["readable_id"],
    shippingJobToken: json["shipping_job_token"],
    shippingPriceNetAmount: json["shipping_price_net_amount"],
    subtotal: json["subtotal"],
    total: json["total"],
    platformFee: json["platform_fee"],
    destinationDuty: json["destination_duty"],
    vat: json["vat"],
    transitInsurance: json["transit_insurance"],
    orders:
        json["orders"] == null
            ? []
            : List<String>.from(json["orders"]!.map((x) => x)),
  );
}

class ShippingAddress {
  int? id;
  String? addressType;
  String? fullName;
  String? primaryPhoneNumber;
  String? secondaryPhoneNumber;
  String? addressLine1;
  dynamic addressLine2;
  String? city;
  String? stateProvince;
  String? postalCode;
  String? country;
  bool? isDefault;
  String? fileUrl;
  String? latitude;
  String? longitude;
  dynamic currency;

  ShippingAddress({
    this.id,
    this.addressType,
    this.fullName,
    this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.stateProvince,
    this.postalCode,
    this.country,
    this.isDefault,
    this.fileUrl,
    this.latitude,
    this.longitude,
    this.currency,
  });

  factory ShippingAddress.fromRawJson(String str) =>
      ShippingAddress.fromJson(json.decode(str));

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        addressType: json["address_type"],
        fullName: json["full_name"],
        primaryPhoneNumber: json["primary_phone_number"],
        secondaryPhoneNumber: json["secondary_phone_number"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        city: json["city"],
        stateProvince: json["state_province"],
        postalCode: json["postal_code"],
        country: json["country"],
        isDefault: json["is_default"],
        fileUrl: json["file_url"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        currency: json["currency"],
      );
}

class Product {
  String? id;
  Seller? seller;
  Category? category;
  Brand? brand;
  List<dynamic>? reviews;
  List<dynamic>? variations;
  String? name;
  String? sku;
  dynamic modelNumber;
  String? productType;
  String? badge;
  String? shortDescription;
  String? longDescription;
  dynamic keyFeatures;
  String? mainImage;
  List<String>? gallery;
  dynamic videoUrl;
  String? regularPrice;
  String? localTransitFee;
  String? salePrice;
  dynamic currency;
  int? availableStock;
  int? lowStockAlert;
  dynamic purchaseLimit;
  String? commissionPercentage;
  String? weight;
  String? weightUnit;
  dynamic shippingWeight;
  String? shippingWeightUnit;
  Dimensions? dimensions;
  dynamic packagingDimensions;
  List<PackagingDetail>? packagingDetails;
  String? shippingMethods;
  String? shippingRegion;
  List<String>? shippingCountries;
  String? handlingTime;
  String? returnsPolicy;
  String? tags;
  dynamic seoTitle;
  String? metaDescription;
  String? status;
  dynamic publishDate;
  String? visibility;
  dynamic specificCustomerGroups;
  dynamic lastUpdatedBy;
  dynamic technicalSpecifications;
  bool? hasVariant;
  bool? woodenBoxPackaging;
  bool? isPerfume;
  bool? containsBattery;
  bool? isCosmetics;
  bool? containsMagnet;
  bool? selfFulfilled;
  String? countryOfOrigin;
  String? hsCode;
  bool? isActive;
  String? createdAt;
  String? lastUpdatedAt;

  Product({
    this.id,
    this.seller,
    this.category,
    this.brand,
    this.reviews,
    this.variations,
    this.name,
    this.sku,
    this.modelNumber,
    this.productType,
    this.badge,
    this.shortDescription,
    this.longDescription,
    this.keyFeatures,
    this.mainImage,
    this.gallery,
    this.videoUrl,
    this.regularPrice,
    this.localTransitFee,
    this.salePrice,
    this.currency,
    this.availableStock,
    this.lowStockAlert,
    this.purchaseLimit,
    this.commissionPercentage,
    this.weight,
    this.weightUnit,
    this.shippingWeight,
    this.shippingWeightUnit,
    this.dimensions,
    this.packagingDimensions,
    this.packagingDetails,
    this.shippingMethods,
    this.shippingRegion,
    this.shippingCountries,
    this.handlingTime,
    this.returnsPolicy,
    this.tags,
    this.seoTitle,
    this.metaDescription,
    this.status,
    this.publishDate,
    this.visibility,
    this.specificCustomerGroups,
    this.lastUpdatedBy,
    this.technicalSpecifications,
    this.hasVariant,
    this.woodenBoxPackaging,
    this.isPerfume,
    this.containsBattery,
    this.isCosmetics,
    this.containsMagnet,
    this.selfFulfilled,
    this.countryOfOrigin,
    this.hsCode,
    this.isActive,
    this.createdAt,
    this.lastUpdatedAt,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    category:
        json["category"] == null ? null : Category.fromJson(json["category"]),
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    reviews:
        json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    variations:
        json["variations"] == null
            ? []
            : List<dynamic>.from(json["variations"]!.map((x) => x)),
    name: json["name"],
    sku: json["sku"],
    modelNumber: json["model_number"],
    productType: json["product_type"],
    badge: json["badge"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    keyFeatures: json["key_features"],
    mainImage: json["main_image"],
    gallery:
        json["gallery"] == null
            ? []
            : List<String>.from(json["gallery"]!.map((x) => x)),
    videoUrl: json["video_url"],
    regularPrice: json["regular_price"],
    localTransitFee: json["local_transit_fee"],
    salePrice: json["sale_price"],
    currency: json["currency"],
    availableStock: json["available_stock"],
    lowStockAlert: json["low_stock_alert"],
    purchaseLimit: json["purchase_limit"],
    commissionPercentage: json["commission_percentage"],
    weight: json["weight"],
    weightUnit: json["weight_unit"],
    shippingWeight: json["shipping_weight"],
    shippingWeightUnit: json["shipping_weight_unit"],
    dimensions:
        json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
    packagingDimensions: json["packaging_dimensions"],
    packagingDetails:
        json["packaging_details"] == null
            ? []
            : List<PackagingDetail>.from(
              json["packaging_details"]!.map(
                (x) => PackagingDetail.fromJson(x),
              ),
            ),
    shippingMethods: json["shipping_methods"],
    shippingRegion: json["shipping_region"],
    shippingCountries:
        json["shipping_countries"] == null
            ? []
            : List<String>.from(json["shipping_countries"]!.map((x) => x)),
    handlingTime: json["handling_time"],
    returnsPolicy: json["returns_policy"],
    tags: json["tags"],
    seoTitle: json["seo_title"],
    metaDescription: json["meta_description"],
    status: json["status"],
    publishDate: json["publish_date"],
    visibility: json["visibility"],
    specificCustomerGroups: json["specific_customer_groups"],
    lastUpdatedBy: json["last_updated_by"],
    technicalSpecifications: json["technical_specifications"],
    hasVariant: json["has_variant"],
    woodenBoxPackaging: json["wooden_box_packaging"],
    isPerfume: json["is_perfume"],
    containsBattery: json["contains_battery"],
    isCosmetics: json["is_cosmetics"],
    containsMagnet: json["contains_magnet"],
    selfFulfilled: json["self_fulfilled"],
    countryOfOrigin: json["country_of_origin"],
    hsCode: json["hs_code"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    lastUpdatedAt: json["last_updated_at"],
  );
}

class Brand {
  int? id;
  String? name;
  String? description;

  Brand({this.id, this.name, this.description});

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );
}

class Category {
  int? id;
  String? name;
  int? parent;
  List<dynamic>? subcategories;
  Map<String, List<String>>? allowedAttributes;

  Category({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    this.allowedAttributes,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    subcategories:
        json["subcategories"] == null
            ? []
            : List<dynamic>.from(json["subcategories"]!.map((x) => x)),
    allowedAttributes: Map.from(json["allowed_attributes"]!).map(
      (k, v) =>
          MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x))),
    ),
  );
}

class Dimensions {
  Height? width;
  Height? height;
  Height? length;

  Dimensions({this.width, this.height, this.length});

  factory Dimensions.fromRawJson(String str) =>
      Dimensions.fromJson(json.decode(str));

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    width: json["width"] == null ? null : Height.fromJson(json["width"]),
    height: json["height"] == null ? null : Height.fromJson(json["height"]),
    length: json["length"] == null ? null : Height.fromJson(json["length"]),
  );
}

class Height {
  String? unit;
  dynamic value;

  Height({this.unit, this.value});

  factory Height.fromRawJson(String str) => Height.fromJson(json.decode(str));

  factory Height.fromJson(Map<String, dynamic> json) =>
      Height(unit: json["unit"], value: json["value"]);
}

class PackagingDetail {
  Height? width;
  Height? height;
  Height? length;
  Height? weight;
  String? woodenBoxPackaging;

  PackagingDetail({
    this.width,
    this.height,
    this.length,
    this.weight,
    this.woodenBoxPackaging,
  });

  factory PackagingDetail.fromRawJson(String str) =>
      PackagingDetail.fromJson(json.decode(str));

  factory PackagingDetail.fromJson(Map<String, dynamic> json) =>
      PackagingDetail(
        width: json["width"] == null ? null : Height.fromJson(json["width"]),
        height: json["height"] == null ? null : Height.fromJson(json["height"]),
        length: json["length"] == null ? null : Height.fromJson(json["length"]),
        weight: json["weight"] == null ? null : Height.fromJson(json["weight"]),
        woodenBoxPackaging: json["wooden_box_packaging"],
      );
}

class Seller {
  int? id;
  String? businessName;

  Seller({this.id, this.businessName});

  factory Seller.fromRawJson(String str) => Seller.fromJson(json.decode(str));

  factory Seller.fromJson(Map<String, dynamic> json) =>
      Seller(id: json["id"], businessName: json["business_name"]);
}

class Variant {
  String? size;
  String? color;
  String? material;
  String? style;
  dynamic count;
  String? capacity;
  String? powerConsumption;
  String? voltage;
  String? packSize;
  dynamic expirationDate;
  String? energyRating;
  String? warrantyPeriod;
  String? pattern;
  String? occasion;
  String? name;
  String? sku;
  String? modelNumber;
  String? mainImage;
  dynamic gallery;
  String? videoUrl;
  dynamic regularPrice;
  dynamic salePrice;
  String? currency;
  dynamic availableStock;
  dynamic lowStockAlert;
  dynamic purchaseLimit;
  dynamic weight;
  dynamic weightUnit;
  dynamic shippingWeight;
  dynamic shippingWeightUnit;
  dynamic dimensions;
  dynamic packagingDimensions;
  dynamic packagingDetails;
  dynamic shippingMethods;
  dynamic shippingRegion;
  dynamic shippingCountries;
  String? handlingTime;
  String? tags;
  String? seoTitle;
  String? metaDescription;
  dynamic status;
  dynamic publishDate;
  dynamic visibility;
  dynamic specificCustomerGroups;
  bool? woodenBoxPackaging;
  bool? isPerfume;
  bool? containsBattery;
  bool? isCosmetics;
  bool? containsMagnet;
  bool? selfFulfilled;
  String? countryOfOrigin;
  String? hsCode;
  String? lastUpdatedBy;
  dynamic technicalSpecifications;
  bool? isActive;
  dynamic product;

  Variant({
    this.size,
    this.color,
    this.material,
    this.style,
    this.count,
    this.capacity,
    this.powerConsumption,
    this.voltage,
    this.packSize,
    this.expirationDate,
    this.energyRating,
    this.warrantyPeriod,
    this.pattern,
    this.occasion,
    this.name,
    this.sku,
    this.modelNumber,
    this.mainImage,
    this.gallery,
    this.videoUrl,
    this.regularPrice,
    this.salePrice,
    this.currency,
    this.availableStock,
    this.lowStockAlert,
    this.purchaseLimit,
    this.weight,
    this.weightUnit,
    this.shippingWeight,
    this.shippingWeightUnit,
    this.dimensions,
    this.packagingDimensions,
    this.packagingDetails,
    this.shippingMethods,
    this.shippingRegion,
    this.shippingCountries,
    this.handlingTime,
    this.tags,
    this.seoTitle,
    this.metaDescription,
    this.status,
    this.publishDate,
    this.visibility,
    this.specificCustomerGroups,
    this.woodenBoxPackaging,
    this.isPerfume,
    this.containsBattery,
    this.isCosmetics,
    this.containsMagnet,
    this.selfFulfilled,
    this.countryOfOrigin,
    this.hsCode,
    this.lastUpdatedBy,
    this.technicalSpecifications,
    this.isActive,
    this.product,
  });

  factory Variant.fromRawJson(String str) => Variant.fromJson(json.decode(str));

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    size: json["size"],
    color: json["color"],
    material: json["material"],
    style: json["style"],
    count: json["count"],
    capacity: json["capacity"],
    powerConsumption: json["power_consumption"],
    voltage: json["voltage"],
    packSize: json["pack_size"],
    expirationDate: json["expiration_date"],
    energyRating: json["energy_rating"],
    warrantyPeriod: json["warranty_period"],
    pattern: json["pattern"],
    occasion: json["occasion"],
    name: json["name"],
    sku: json["sku"],
    modelNumber: json["model_number"],
    mainImage: json["main_image"],
    gallery: json["gallery"],
    videoUrl: json["video_url"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    currency: json["currency"],
    availableStock: json["available_stock"],
    lowStockAlert: json["low_stock_alert"],
    purchaseLimit: json["purchase_limit"],
    weight: json["weight"],
    weightUnit: json["weight_unit"],
    shippingWeight: json["shipping_weight"],
    shippingWeightUnit: json["shipping_weight_unit"],
    dimensions: json["dimensions"],
    packagingDimensions: json["packaging_dimensions"],
    packagingDetails: json["packaging_details"],
    shippingMethods: json["shipping_methods"],
    shippingRegion: json["shipping_region"],
    shippingCountries: json["shipping_countries"],
    handlingTime: json["handling_time"],
    tags: json["tags"],
    seoTitle: json["seo_title"],
    metaDescription: json["meta_description"],
    status: json["status"],
    publishDate: json["publish_date"],
    visibility: json["visibility"],
    specificCustomerGroups: json["specific_customer_groups"],
    woodenBoxPackaging: json["wooden_box_packaging"],
    isPerfume: json["is_perfume"],
    containsBattery: json["contains_battery"],
    isCosmetics: json["is_cosmetics"],
    containsMagnet: json["contains_magnet"],
    selfFulfilled: json["self_fulfilled"],
    countryOfOrigin: json["country_of_origin"],
    hsCode: json["hs_code"],
    lastUpdatedBy: json["last_updated_by"],
    technicalSpecifications: json["technical_specifications"],
    isActive: json["is_active"],
    product: json["product"],
  );
}

class DatumParent {
  String? readableId;
  String? shippingJobToken;
  String? shippingPriceNetAmount;
  String? subtotal;
  String? total;
  String? platformFee;
  String? destinationDuty;
  String? vat;
  String? localTransitFee;
  String? transitInsurance;
  List<OrderElement>? orders;

  DatumParent({
    this.readableId,
    this.shippingJobToken,
    this.shippingPriceNetAmount,
    this.subtotal,
    this.total,
    this.platformFee,
    this.destinationDuty,
    this.vat,
    this.localTransitFee,
    this.transitInsurance,
    this.orders,
  });

  factory DatumParent.fromRawJson(String str) =>
      DatumParent.fromJson(json.decode(str));

  factory DatumParent.fromJson(Map<String, dynamic> json) => DatumParent(
    readableId: json["readable_id"],
    shippingJobToken: json["shipping_job_token"],
    shippingPriceNetAmount: json["shipping_price_net_amount"],
    subtotal: json["subtotal"],
    total: json["total"],
    platformFee: json["platform_fee"],
    destinationDuty: json["destination_duty"],
    vat: json["vat"],
    localTransitFee: json["local_transit_fee"],
    transitInsurance: json["transit_insurance"],
    orders:
        json["orders"] == null
            ? []
            : List<OrderElement>.from(
              json["orders"]!.map((x) => OrderElement.fromJson(x)),
            ),
  );
}

class OrderElement {
  String? id;
  List<OrderItem>? items;
  String? readableId;

  OrderElement({this.id, this.items, this.readableId});

  factory OrderElement.fromRawJson(String str) =>
      OrderElement.fromJson(json.decode(str));

  factory OrderElement.fromJson(Map<String, dynamic> json) => OrderElement(
    id: json["id"],
    items:
        json["items"] == null
            ? []
            : List<OrderItem>.from(
              json["items"]!.map((x) => OrderItem.fromJson(x)),
            ),
    readableId: json["readable_id"],
  );
}
