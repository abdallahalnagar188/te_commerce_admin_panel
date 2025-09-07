class TRoutes {
  static const responsiveDesignTutorialScreen = '/responsive-design-tutorial/';

  static const login = '/login';
  static const logout = '/logout';
  static const forgetPassword = '/forget-password/';
  static const resetPassword = '/reset-password';

  static const dashboard = '/dashboard';
  static const media = '/media';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editeBanner = '/editeBanner';

  static const products = '/products';
  static const createProduct = '/createProduct';
  static const editeProduct = '/editeProduct';

  static const categories = '/categories';
  static const createCategory = '/category/createCategory';
  static const editeCategory = '/editeCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editeBrand = '/editeBrand';

  static const customers = '/customers';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const orderDetails = '/orderDetails';

  static const coupons = '/coupons';
  static const settings = '/settings';
  static const profile = '/profile';

  static var sideBarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers,
    orders,
    coupons,
    settings,
    profile
  ];
}
