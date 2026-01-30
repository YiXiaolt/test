import { router } from '@kit.ArkUI';
import {http} from '@kit.NetworkKit';
import { JSON } from '@kit.ArkTS';
import image from '@ohos.multimedia.image';
import { RootObject } from '../bean/RootObject';

@Entry
@Component
struct Register {
  @State errorMsg: string = '';
  @State account: string = "";
  @State password: string="";
  @State repassword: string="";

  req=http.createHttp()

  build() {
    Column(){
      Text("wanandroid")
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .width("100%")
        .margin(25)

      Column({space:15}){
        Text("昵称")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .width("100%")
        TextInput({
          placeholder:"请输入注册账号名"
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


        Text("确认密码")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .width("100%")


        TextInput({
          placeholder:"请再一次填写确认密码"
        })
          .type(InputType.Password)
          .backgroundColor(Color.White)
          .border({
            width:{bottom:1}
          })
          .borderRadius(0)
          .onChange(value=>{
            this.repassword=value
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
        Button("注册")
          .fontSize(22)
          .backgroundColor("#ff1a97f1")
          .width("45%")
          .margin(50)
          .onClick(()=>{
            this.req.request(`https://www.wanandroid.com/user/register?username=${this.account}&password=${this.password}&repassword=${this.repassword}`,{
              method:http.RequestMethod.POST,
              header: {
                'Content-Type': 'application/json;charset=utf-8',
                'Accept':'application/json'
              },
              extraData:JSON.stringify({
                username:this.account,
                password:this.password,
                repassword:this.repassword
              }),
              connectTimeout: 10000,
              readTimeout: 10000
            }).then(res=>{
              let r:RootObject=JSON.parse(res.result+'') as RootObject
              console.log("POST",JSON.stringify(r.data))
              if(r.errorCode==-1){
                this.errorMsg=r.errorMsg
              }else{
                router.pushUrl({
                  url:"pages/Login"
                })
              }
            })
          })


      }

      Text(this.errorMsg)
    }
    .padding(25)
    .height('100%')
    .width('100%')
  }
}