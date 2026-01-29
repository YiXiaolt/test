import { router } from '@kit.ArkUI';

@Entry
@Component
struct Register {
  @State message: string = 'Hello World';

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
          placeholder:"请输入注册账号"
        })
          .type(InputType.Normal)
          .backgroundColor(Color.White)
          .border({
            width:{bottom:1}
          })
          .borderRadius(0)

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
            router.pushUrl({
              url:"pages/Login"
            })
          })


      }

    }
    .padding(25)
    .height('100%')
    .width('100%')
  }
}