package com.taomee.seer2.app.notify.data.notice
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class VipNotice extends Notice
   {
       
      
      private var _payFlag:int;
      
      private var _leftDays:int;
      
      public function VipNotice(param1:int, param2:int)
      {
         super(NoticeType.VIP,ActorManager.actorInfo.id);
         this._payFlag = param1;
         this._leftDays = param2;
      }
      
      override public function process() : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("VipNoticePanel"),"正在VIP通知资源...",{
            "flag":this._payFlag,
            "days":this._leftDays
         });
      }
   }
}
