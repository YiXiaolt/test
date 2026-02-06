import {ToDoData} from '../bean/ToDoData'


@CustomDialog
export struct editDialog {
  controller:CustomDialogController;
  currentitem:ToDoData= new ToDoData(false, '', new Date().getTime());
  value:string=''
  confirm:(value:string,item:ToDoData)=>void=(value:string,item:ToDoData)=>{ };
  onCancel: () => void = () => {};
  build() {
    Column({space:10}){
      Text("编辑")
      TextInput({placeholder:"编辑待办事项为"})
        .type(InputType.Normal)
        .onChange(value=>{
          this.value=value
        })
      Row({space:40}){
        Button("确认")
          .onClick(()=>{
            this.confirm(this.value,this.currentitem)
            this.onCancel()
          })
        Button("取消")
          .onClick(()=>{
            this.onCancel()
          })

      }
    }
    .padding(10)
  }
}

