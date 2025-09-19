import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/features/auth/controllers/user_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneController.text = controller.user.value.phoneNumber;
    return Column(
      children: [
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              // First and Last Name
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Row(
                        spacing: TSizes.md,
                        children: [
                          // First Name
                          Expanded(
                              child: TextFormField(
                            controller: controller.firstNameController,
                            decoration: const InputDecoration(
                                hintText: 'First Name',
                                label: Text('First Name'),
                                prefixIcon: Icon(Iconsax.user)),
                            validator: (value) => TValidator.validateEmptyText(
                                'First Name', value),
                          )),
                          const SizedBox(
                            height: TSizes.spaceBtwInputFields,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                                hintText: 'Last Name',
                                label: Text('Last Name'),
                                prefixIcon: Icon(Iconsax.user)),
                            validator: (value) => TValidator.validateEmptyText(
                                'Last Name', value),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      // Email and Phone
                      Row(
                        spacing: TSizes.md,
                        children: [
                          // First Name
                          Expanded(
                              child: TextFormField(
                            controller: controller.phoneController,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                label: Text('Email'),
                                prefixIcon: Icon(Iconsax.forward),
                                enabled: false),
                          )),
                          const SizedBox(
                            height: TSizes.spaceBtwInputFields,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: controller.phoneController,
                            decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                label: Text('Phone Number'),
                                prefixIcon: Icon(Iconsax.mobile)),
                            validator: (value) => TValidator.validateEmptyText(
                                'Phone Number', value),
                          )),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              SizedBox(
                width: double.infinity,
                child: Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => controller.updateUser(),
                        child: Text('Update Profile'))),
              )
            ],
          ),
        )
      ],
    );
  }
}
