package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class NpcChallenge
   {
      
      private static var _instance:NpcChallenge;
       
      
      private var _npc:Mobile;
      
      private var _npcid:int;
      
      public function NpcChallenge()
      {
         super();
      }
      
      public static function getInstance() : NpcChallenge
      {
         if(!_instance)
         {
            _instance = new NpcChallenge();
         }
         return _instance;
      }
      
      public function init(param1:int, param2:Array) : void
      {
         var index:int = 0;
         var npcId:int = param1;
         var positionIndex:Array = param2;
         this._npcid = npcId;
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.showNpcChallengePanel);
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            index = positionIndex.indexOf(FightManager.currentFightRecord.initData["positionIndex"]);
            if(index != -1 && !FightManager.isJustWinFight())
            {
               NpcDialog.show(npcId,MobileManager.getMobile(npcId,MobileType.NPC).label,[[0,"我可不是一般的精灵，要战胜我可不是这么简单的事哦。"]],["还是放弃吧"," 再来一次！ "],[null,function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("NpcChallengePanel"),"打开中...",{"npcid":_npcid});
               }]);
            }
         }
      }
      
      private function showNpcChallengePanel(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "OpenNpcChallengePanel")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("NpcChallengePanel"),"打开中...",{"npcid":this._npcid});
         }
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.showNpcChallengePanel);
      }
   }
}
