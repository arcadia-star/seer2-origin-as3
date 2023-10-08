package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_80465 extends MapProcessor
   {
       
      
      private var _npc437:Mobile;
      
      public function MapProcessor_80465(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.createNpc437();
      }
      
      private function createNpc437() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc437)
         {
            this._npc437 = new Mobile();
            this._npc437.setPostion(new Point(545,447));
            this._npc437.resourceUrl = URLUtil.getNpcSwf(437);
            this._npc437.buttonMode = true;
            MobileManager.addMobile(this._npc437,MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc437.addChild(_loc1_);
            _loc1_.y = -90;
            this._npc437.addEventListener(MouseEvent.CLICK,this.onDialog);
         }
      }
      
      private function onDialog(param1:MouseEvent) : void
      {
         NpcDialog.show(437,"砂吉塔",[[0,"你们想要那个破碎的瓶子？瓦利大叔呢？他不在我可不会给你，除非你打赢我。"]],["废话少说，开始吧! ","等我准备准备"],[this.onFightShasha,null]);
      }
      
      private function onFightShasha() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onCompleteSwitch);
         FightManager.startFightWithWild(1596);
      }
      
      private function onCompleteSwitch(param1:SceneEvent) : void
      {
         var e:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onCompleteSwitch);
            if(1596 == FightManager.currentFightRecord.initData.positionIndex)
            {
               if(FightManager.isWinWar())
               {
                  ServerMessager.addMessage("获得1个【玻璃碎片】。");
                  ActiveCountManager.requestActiveCount(250254,function(param1:int, param2:int):void
                  {
                     if(param2 >= 5)
                     {
                        ModuleManager.toggleModule(URLUtil.getAppModule("YuanHunBeastPanel"),"","2");
                     }
                  });
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._npc437)
         {
            MobileManager.removeMobile(this._npc437,MobileType.PET);
            this._npc437 = null;
         }
      }
   }
}
