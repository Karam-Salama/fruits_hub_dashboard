import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/repos/add_product_repos/product_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/images_repos/images_repo.dart';
import '../../../domain/entities/product_entity.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.imagesRepo, this.productRepo)
      : super(AddProductInitial());

  final ImagesRepo imagesRepo;
  final ProductRepo productRepo;

  Future<void> addProduct(ProductEntity addProductEntity) async {
    emit(AddProductLoading());
    var result = await imagesRepo.uploadImage(addProductEntity.image);
    result.fold(
      (failure) {
        emit(AddProductFailure(failure.message));
      },
      (imageUrl) async {
        addProductEntity.imageUrl = imageUrl;
        var result = await productRepo.addProduct(addProductEntity);
        result.fold(
          (failure) {
            emit(AddProductFailure(failure.message));
          },
          (success) {
            emit(AddProductSuccess());
          },
        );
      },
    );
  }

  Future<void> updateProduct(ProductEntity updateProductEntity) async {
    emit(AddProductLoading());
    var result = await productRepo.updateProduct(updateProductEntity);
    result.fold(
      (failure) {
        emit(AddProductFailure(failure.message));
      },
      (success) {
        emit(AddProductSuccess());
      },
    );
  }

  Future<void> updateProductWithImage(
    ProductEntity productEntity,
    dynamic newImage,
  ) async {
    emit(AddProductLoading());
    var result = await imagesRepo.uploadImage(newImage);
    result.fold(
      (failure) {
        emit(AddProductFailure(failure.message));
      },
      (imageUrl) async {
        productEntity.imageUrl = imageUrl;
        var updateResult = await productRepo.updateProduct(productEntity);
        updateResult.fold(
          (failure) {
            emit(AddProductFailure(failure.message));
          },
          (success) {
            emit(AddProductSuccess());
          },
        );
      },
    );
  }
}
