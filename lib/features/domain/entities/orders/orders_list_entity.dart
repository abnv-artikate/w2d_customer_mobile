class OrderListEntity {
  final int count;
  final dynamic next;
  final dynamic previous;
  final Results results;

  OrderListEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

}

class Results {
  final String status;
  final String message;
  final List<Datum> data;

  Results({
    required this.status,
    required this.message,
    required this.data,
  });

}

class Datum {
  final String id;
  final String readableId;
  final dynamic original;
  final Seller seller;
  final Customer customer;
  final String customerEmail;
  final String status;
  final String chargeStatus;
  final dynamic billingAddress;
  final ShippingAddress shippingAddress;
  final dynamic shippingTaxRate;
  final dynamic shippingTaxClass;
  final dynamic shippingTaxClassName;
  final String currency;
  final String shippingPriceNetAmount;
  final String subtotal;
  final String total;
  final String platformFee;
  final String destinationDuty;
  final String vat;
  final String transitInsurance;
  final String localTransitFee;
  final String invoiceNumber;
  final bool displayGrossPrices;
  final String customerNote;
  final dynamic redirectUrl;
  final String searchDocument;
  final dynamic searchVector;
  final String createdAt;
  final String updatedAt;
  final dynamic expiredAt;
  final List<DatumItem> items;
  final List<DatumParent> parent;

  Datum({
    required this.id,
    required this.readableId,
    required this.original,
    required this.seller,
    required this.customer,
    required this.customerEmail,
    required this.status,
    required this.chargeStatus,
    required this.billingAddress,
    required this.shippingAddress,
    required this.shippingTaxRate,
    required this.shippingTaxClass,
    required this.shippingTaxClassName,
    required this.currency,
    required this.shippingPriceNetAmount,
    required this.subtotal,
    required this.total,
    required this.platformFee,
    required this.destinationDuty,
    required this.vat,
    required this.transitInsurance,
    required this.localTransitFee,
    required this.invoiceNumber,
    required this.displayGrossPrices,
    required this.customerNote,
    required this.redirectUrl,
    required this.searchDocument,
    required this.searchVector,
    required this.createdAt,
    required this.updatedAt,
    required this.expiredAt,
    required this.items,
    required this.parent,
  });

}

class Customer {
  final String email;
  final String fullName;
  final dynamic mobileNumber;
  final dynamic secondaryMobileNumber;
  final String country;

  Customer({
    required this.email,
    required this.fullName,
    required this.mobileNumber,
    required this.secondaryMobileNumber,
    required this.country,
  });

}

class DatumItem {
  final String id;
  final ItemOrder order;
  final bool isReturned;
  final String readableId;
  final String status;
  final dynamic currency;
  final Product product;
  final Variant variant;
  final String productName;
  final String variantName;
  final String translatedProductName;
  final String translatedVariantName;
  final int quantity;
  final String unitDiscountAmount;
  final String unitPrice;
  final String totalPrice;
  final String taxRate;
  final dynamic taxClass;
  final String taxClassName;
  final bool isPriceOverridden;
  final dynamic voucherCode;
  final String saleId;
  final String updatedAt;

  DatumItem({
    required this.id,
    required this.order,
    required this.isReturned,
    required this.readableId,
    required this.status,
    required this.currency,
    required this.product,
    required this.variant,
    required this.productName,
    required this.variantName,
    required this.translatedProductName,
    required this.translatedVariantName,
    required this.quantity,
    required this.unitDiscountAmount,
    required this.unitPrice,
    required this.totalPrice,
    required this.taxRate,
    required this.taxClass,
    required this.taxClassName,
    required this.isPriceOverridden,
    required this.voucherCode,
    required this.saleId,
    required this.updatedAt,
  });

}

class ItemOrder {
  final String id;
  final dynamic original;
  final List<OrderParent> parent;
  final int seller;
  final Customer customer;
  final String readableId;
  final String customerEmail;
  final String status;
  final String chargeStatus;
  final dynamic billingAddress;
  final ShippingAddress shippingAddress;
  final dynamic shippingTaxRate;
  final dynamic shippingTaxClass;
  final dynamic shippingTaxClassName;
  final String currency;
  final String shippingPriceNetAmount;
  final String subtotal;
  final String total;
  final bool displayGrossPrices;
  final String customerNote;
  final dynamic redirectUrl;
  final String searchDocument;
  final dynamic searchVector;
  final String createdAt;
  final String updatedAt;
  final dynamic expiredAt;
  final List<OrderItem> items;

  ItemOrder({
    required this.id,
    required this.original,
    required this.parent,
    required this.seller,
    required this.customer,
    required this.readableId,
    required this.customerEmail,
    required this.status,
    required this.chargeStatus,
    required this.billingAddress,
    required this.shippingAddress,
    required this.shippingTaxRate,
    required this.shippingTaxClass,
    required this.shippingTaxClassName,
    required this.currency,
    required this.shippingPriceNetAmount,
    required this.subtotal,
    required this.total,
    required this.displayGrossPrices,
    required this.customerNote,
    required this.redirectUrl,
    required this.searchDocument,
    required this.searchVector,
    required this.createdAt,
    required this.updatedAt,
    required this.expiredAt,
    required this.items,
  });

}

class OrderItem {
  final String id;
  final String readableId;
  final String order;
  final String status;
  final dynamic currency;
  final String product;
  final dynamic variant;
  final String productName;
  final String variantName;
  final String translatedProductName;
  final String translatedVariantName;
  final int quantity;
  final String unitDiscountAmount;
  final String unitPrice;
  final String totalPrice;
  final String taxRate;
  final dynamic taxClass;
  final String taxClassName;
  final bool isPriceOverridden;
  final dynamic voucherCode;
  final String saleId;
  final String updatedAt;
  final bool? isReturned;

  OrderItem({
    required this.id,
    required this.readableId,
    required this.order,
    required this.status,
    required this.currency,
    required this.product,
    required this.variant,
    required this.productName,
    required this.variantName,
    required this.translatedProductName,
    required this.translatedVariantName,
    required this.quantity,
    required this.unitDiscountAmount,
    required this.unitPrice,
    required this.totalPrice,
    required this.taxRate,
    required this.taxClass,
    required this.taxClassName,
    required this.isPriceOverridden,
    required this.voucherCode,
    required this.saleId,
    required this.updatedAt,
    this.isReturned,
  });

}

class OrderParent {
  final String readableId;
  final String? shippingJobToken;
  final String shippingPriceNetAmount;
  final String subtotal;
  final String total;
  final String platformFee;
  final String destinationDuty;
  final String vat;
  final String transitInsurance;
  final List<String> orders;

  OrderParent({
    required this.readableId,
    required this.shippingJobToken,
    required this.shippingPriceNetAmount,
    required this.subtotal,
    required this.total,
    required this.platformFee,
    required this.destinationDuty,
    required this.vat,
    required this.transitInsurance,
    required this.orders,
  });

}

class ShippingAddress {
  final int id;
  final String addressType;
  final String fullName;
  final String primaryPhoneNumber;
  final String secondaryPhoneNumber;
  final String addressLine1;
  final dynamic addressLine2;
  final String city;
  final String stateProvince;
  final String postalCode;
  final String country;
  final bool isDefault;
  final String? fileUrl;
  final String? latitude;
  final String? longitude;
  final dynamic currency;

  ShippingAddress({
    required this.id,
    required this.addressType,
    required this.fullName,
    required this.primaryPhoneNumber,
    required this.secondaryPhoneNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.stateProvince,
    required this.postalCode,
    required this.country,
    required this.isDefault,
    this.fileUrl,
    this.latitude,
    this.longitude,
    this.currency,
  });

}

class Product {
  final String id;
  final Seller seller;
  final Category category;
  final Brand brand;
  final List<dynamic> reviews;
  final List<dynamic> variations;
  final String name;
  final String sku;
  final dynamic modelNumber;
  final String productType;
  final String badge;
  final String shortDescription;
  final String longDescription;
  final dynamic keyFeatures;
  final String mainImage;
  final List<String> gallery;
  final dynamic videoUrl;
  final String regularPrice;
  final String localTransitFee;
  final String salePrice;
  final dynamic currency;
  final int availableStock;
  final int lowStockAlert;
  final dynamic purchaseLimit;
  final String commissionPercentage;
  final String weight;
  final String weightUnit;
  final dynamic shippingWeight;
  final String shippingWeightUnit;
  final Dimensions dimensions;
  final dynamic packagingDimensions;
  final List<PackagingDetail> packagingDetails;
  final String shippingMethods;
  final String shippingRegion;
  final List<String> shippingCountries;
  final String handlingTime;
  final String? returnsPolicy;
  final String? tags;
  final dynamic seoTitle;
  final String? metaDescription;
  final String status;
  final dynamic publishDate;
  final String visibility;
  final dynamic specificCustomerGroups;
  final dynamic lastUpdatedBy;
  final TechnicalSpecifications technicalSpecifications;
  final bool hasVariant;
  final bool woodenBoxPackaging;
  final bool isPerfume;
  final bool containsBattery;
  final bool isCosmetics;
  final bool containsMagnet;
  final bool selfFulfilled;
  final String countryOfOrigin;
  final String hsCode;
  final bool isActive;
  final String createdAt;
  final String lastUpdatedAt;

  Product({
    required this.id,
    required this.seller,
    required this.category,
    required this.brand,
    required this.reviews,
    required this.variations,
    required this.name,
    required this.sku,
    required this.modelNumber,
    required this.productType,
    required this.badge,
    required this.shortDescription,
    required this.longDescription,
    required this.keyFeatures,
    required this.mainImage,
    required this.gallery,
    required this.videoUrl,
    required this.regularPrice,
    required this.localTransitFee,
    required this.salePrice,
    required this.currency,
    required this.availableStock,
    required this.lowStockAlert,
    required this.purchaseLimit,
    required this.commissionPercentage,
    required this.weight,
    required this.weightUnit,
    required this.shippingWeight,
    required this.shippingWeightUnit,
    required this.dimensions,
    required this.packagingDimensions,
    required this.packagingDetails,
    required this.shippingMethods,
    required this.shippingRegion,
    required this.shippingCountries,
    required this.handlingTime,
    required this.returnsPolicy,
    required this.tags,
    required this.seoTitle,
    required this.metaDescription,
    required this.status,
    required this.publishDate,
    required this.visibility,
    required this.specificCustomerGroups,
    required this.lastUpdatedBy,
    required this.technicalSpecifications,
    required this.hasVariant,
    required this.woodenBoxPackaging,
    required this.isPerfume,
    required this.containsBattery,
    required this.isCosmetics,
    required this.containsMagnet,
    required this.selfFulfilled,
    required this.countryOfOrigin,
    required this.hsCode,
    required this.isActive,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

}

class Brand {
  final int id;
  final String name;
  final String? description;

  Brand({
    required this.id,
    required this.name,
    required this.description,
  });

}

class Category {
  final int id;
  final String name;
  final int parent;
  final List<dynamic> subcategories;
  final Map<String, List<String>> allowedAttributes;

  Category({
    required this.id,
    required this.name,
    required this.parent,
    required this.subcategories,
    required this.allowedAttributes,
  });

}

class Dimensions {
  final Height width;
  final Height height;
  final Height length;

  Dimensions({
    required this.width,
    required this.height,
    required this.length,
  });

}

class Height {
  final String unit;
  final dynamic value;

  Height({
    required this.unit,
    required this.value,
  });

}

class PackagingDetail {
  final Height width;
  final Height height;
  final Height length;
  final Height weight;
  final String woodenBoxPackaging;

  PackagingDetail({
    required this.width,
    required this.height,
    required this.length,
    required this.weight,
    required this.woodenBoxPackaging,
  });

}

class Seller {
  final int id;
  final String businessName;

  Seller({
    required this.id,
    required this.businessName,
  });

}

class TechnicalSpecifications {
  TechnicalSpecifications();
}

class Variant {
  final String size;
  final String color;
  final String material;
  final String style;
  final dynamic count;
  final String capacity;
  final String powerConsumption;
  final String voltage;
  final String packSize;
  final dynamic expirationDate;
  final String energyRating;
  final String warrantyPeriod;
  final String pattern;
  final String occasion;
  final String name;
  final String sku;
  final String modelNumber;
  final String mainImage;
  final dynamic gallery;
  final String videoUrl;
  final dynamic regularPrice;
  final dynamic salePrice;
  final String currency;
  final dynamic availableStock;
  final dynamic lowStockAlert;
  final dynamic purchaseLimit;
  final dynamic weight;
  final dynamic weightUnit;
  final dynamic shippingWeight;
  final dynamic shippingWeightUnit;
  final dynamic dimensions;
  final dynamic packagingDimensions;
  final dynamic packagingDetails;
  final dynamic shippingMethods;
  final dynamic shippingRegion;
  final dynamic shippingCountries;
  final String handlingTime;
  final String tags;
  final String seoTitle;
  final String metaDescription;
  final dynamic status;
  final dynamic publishDate;
  final dynamic visibility;
  final dynamic specificCustomerGroups;
  final bool woodenBoxPackaging;
  final bool isPerfume;
  final bool containsBattery;
  final bool isCosmetics;
  final bool containsMagnet;
  final bool selfFulfilled;
  final String countryOfOrigin;
  final String hsCode;
  final String lastUpdatedBy;
  final dynamic technicalSpecifications;
  final bool isActive;
  final dynamic product;

  Variant({
    required this.size,
    required this.color,
    required this.material,
    required this.style,
    required this.count,
    required this.capacity,
    required this.powerConsumption,
    required this.voltage,
    required this.packSize,
    required this.expirationDate,
    required this.energyRating,
    required this.warrantyPeriod,
    required this.pattern,
    required this.occasion,
    required this.name,
    required this.sku,
    required this.modelNumber,
    required this.mainImage,
    required this.gallery,
    required this.videoUrl,
    required this.regularPrice,
    required this.salePrice,
    required this.currency,
    required this.availableStock,
    required this.lowStockAlert,
    required this.purchaseLimit,
    required this.weight,
    required this.weightUnit,
    required this.shippingWeight,
    required this.shippingWeightUnit,
    required this.dimensions,
    required this.packagingDimensions,
    required this.packagingDetails,
    required this.shippingMethods,
    required this.shippingRegion,
    required this.shippingCountries,
    required this.handlingTime,
    required this.tags,
    required this.seoTitle,
    required this.metaDescription,
    required this.status,
    required this.publishDate,
    required this.visibility,
    required this.specificCustomerGroups,
    required this.woodenBoxPackaging,
    required this.isPerfume,
    required this.containsBattery,
    required this.isCosmetics,
    required this.containsMagnet,
    required this.selfFulfilled,
    required this.countryOfOrigin,
    required this.hsCode,
    required this.lastUpdatedBy,
    required this.technicalSpecifications,
    required this.isActive,
    required this.product,
  });

}

class DatumParent {
  final String readableId;
  final String? shippingJobToken;
  final String shippingPriceNetAmount;
  final String subtotal;
  final String total;
  final String platformFee;
  final String destinationDuty;
  final String vat;
  final String localTransitFee;
  final String transitInsurance;
  final List<OrderElement> orders;

  DatumParent({
    required this.readableId,
    required this.shippingJobToken,
    required this.shippingPriceNetAmount,
    required this.subtotal,
    required this.total,
    required this.platformFee,
    required this.destinationDuty,
    required this.vat,
    required this.localTransitFee,
    required this.transitInsurance,
    required this.orders,
  });

}

class OrderElement {
  final String id;
  final List<OrderItem> items;
  final String readableId;

  OrderElement({
    required this.id,
    required this.items,
    required this.readableId,
  });

}
