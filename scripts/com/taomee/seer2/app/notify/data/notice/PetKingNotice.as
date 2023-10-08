package com.taomee.seer2.app.notify.data.notice
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class PetKingNotice extends Notice
   {
       
      
      public function PetKingNotice(param1:String, param2:uint)
      {
         super(NoticeType.PET_KING_PANEL,ActorManager.actorInfo.id);
      }
      
      override public function process() : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("PetKingNoticePanel"),"正在加载资源...");
      }
   }
}
