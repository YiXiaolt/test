// 第一步：显式声明接口，定义全局常量的类型（解决报错的核心）
export interface GlobalConstant {
  // Storage共享键名 - 对应登录信息
  STORAGE_IS_LOGIN: string;
  STORAGE_USER_NAME: string;
  STORAGE_USER_PASSWORD: string;
  STORAGE_COIN_COUNT: string;
  // 接口地址 - 登录/新增TODO
  API_LOGIN: string;
  API_ADD_TODO: string;
}

// 第二步：创建符合接口的常量对象，指定类型为GlobalConstant
export const Constant: GlobalConstant = {
  // Storage键名（保证全App统一，避免拼写错）
  STORAGE_IS_LOGIN: "isLogin",
  STORAGE_USER_NAME: "userName",
  STORAGE_USER_PASSWORD: "password",
  STORAGE_COIN_COUNT: "storage_coinCount",
  // 接口地址（统一管理，改地址只改这里）
  API_LOGIN: "https://www.wanandroid.com/user/login",
  API_ADD_TODO: "https://www.wanandroid.com/lg/todo/add/json"
}