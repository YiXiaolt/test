export
@CustomDialog
struct editDialog {
  controller:CustomDialogController = new CustomDialogController({
    builder:TextInputController
  })
  build() {
    Column({space:10}){
      Text("编辑")
      TextInput({placeholder:"编辑待办事项为"})
        .type(InputType.Normal)
      Row(){
        Button("确认")
          .onClick(()=>{
            this.controller.close()
          })
        Button("取消")
          .onClick(()=>{
            this.controller.open()
          })

      }
    }
  }
}

