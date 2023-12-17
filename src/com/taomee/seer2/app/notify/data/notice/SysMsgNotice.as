package com.taomee.seer2.app.notify.data.notice
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class SysMsgNotice extends Notice
   {
       
      
      private var _obj:Object;
      
      public function SysMsgNotice(param1:Object)
      {
         this._obj = param1;
         super(NoticeType.SYSMSG,ActorManager.actorInfo.id);
      }
      
      override public function process() : void
      {
         if(this._obj.npcType == 1 && ActorManager.actorInfo.id == this._obj.receiveID)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("1_0"),function():void
            {
               ServerMessager.addMessage("晓月兔留下了一张五万经验券，一瓶学习力药水和两瓶性格重置秘药给你");
            },false);
         }
         else if(this._obj.npcType == 0 && ActorManager.actorInfo.id == this._obj.receiveID)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("SysNotisiPanel"),"正在打开...",this._obj);
         }
      }
   }
}
