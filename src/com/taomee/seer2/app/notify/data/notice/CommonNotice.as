package com.taomee.seer2.app.notify.data.notice
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.popup.AlertManager;
   
   public class CommonNotice extends Notice
   {
       
      
      private var _msg:String;
      
      public function CommonNotice(param1:String)
      {
         this._msg = param1;
         super(NoticeType.COMMON,ActorManager.actorInfo.id);
      }
      
      override public function process() : void
      {
         AlertManager.showAlert(this._msg);
      }
   }
}
