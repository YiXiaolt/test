import { router, Router } from '@kit.ArkUI';
import {http} from '@kit.NetworkKit';
import { JSON } from '@kit.ArkTS';
import image from '@ohos.multimedia.image';
import { RootObject } from '../bean/RootObject';
import { Constant } from "../common/Constant"

@Entry
@Component
struct Login {
  @State account: string = "";
  @State password: string="";
  @State errorMSg: string="";

  req=http.createHttp()

  build() {
    Column(){
      Text("wanandroid")
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .width("100%")
        .margin(25)
      Column({space:15}){
        Text("账号")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .width("100%")
        TextInput({
          placeholder:"请输入wanandroid网站账号"
        })
          .type(InputType.Normal)
          .backgroundColor(Color.White)
          .border({
            width:{bottom:1}
          })
          .borderRadius(0)
          .onChange(value=>{
            this.account=value
          })

        Text("密码")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .width("100%")


        TextInput({
          placeholder:"请输入密码"
        })
          .type(InputType.Password)
          .backgroundColor(Color.White)
          .border({
            width:{bottom:1}
          })
          .borderRadius(0)
          .onChange(value=>{
            this.password=value
          })
      }
      .width("100%")
      .border({
        width:1,
        color: "#c4787b81"
      })
      .borderRadius(8)

      .padding(25)
      Row(){
        Button("登录")
          .fontSize(22)
          .backgroundColor("#ff1a97f1")
          .width("45%")
          .margin(50)
          .onClick(()=>{
            this.req.request(`https://www.wanandroid.com/user/login?username=${this.account}&password=${this.password}`,{
              method:http.RequestMethod.POST,
              header:{
                "content-type":"application/json;charset=UTF-8"
              },
              extraData:{
                username:this.account,
                password:this.password
              }
            }).then(res=>{
              console.log("POST",JSON.stringify(res))
              let r:RootObject=JSON.parse(res.result+'') as RootObject
              console.log("POST",r.errorCode)

              if(r.errorCode==0)
              {
                console.log("network",JSON.stringify(r.data))
                router.pushUrl({
                  url:"pages/Index"
                })
                AppStorage.setOrCreate(Constant.STORAGE_IS_LOGIN,false);
                AppStorage.setOrCreate(Constant.STORAGE_USER_NAME, this.account);
                AppStorage.setOrCreate(Constant.STORAGE_USER_PASSWORD, this.password);
              }else{
                this.errorMSg=r.errorMsg

              }

            })
          })

        Text("注册")
          .fontColor("#ff373735")
          .width(50)
          .margin(15)
          .onClick(()=>{
            router.pushUrl({
              url:"pages/Register"
            })
          })
      }
      Text(this.errorMSg)

    }
    .padding(25)
    .height('100%')
    .width('100%')

  }
}