package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.StanceFightPetAct;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_1160 extends MapProcessor
   {
       
      
      private var _npc:Mobile;
      
      private var fightID:Array;
      
      private var isFirst:Boolean = true;
      
      public function MapProcessor_1160(param1:MapModel)
      {
         this.fightID = [1336];
         super(param1);
      }
      
      override public function init() : void
      {
         var result:uint = 0;
         super.init();
         RightToolbarConter.instance.hide();
         StanceFightPetAct.getInstance().npcId = 184;
         StanceFightPetAct.getInstance().showFull = "showDragon";
         StanceFightPetAct.getInstance().leaveFull = "leaveDragon";
         StanceFightPetAct.getInstance().setup(765);
         this.createNPC();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this.fightID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
            {
               result = FightManager.fightWinnerSide;
               if(result == FightSide.RIGHT)
               {
                  NpcDialog.show(828,"黑暗斗魂",[[0,"哈哈哈哈，我果然是不可战胜的！"]],["下次我一定会打败你！"],[function():void
                  {
                     isFirst = false;
                  }]);
               }
               else if(result == FightSide.LEFT)
               {
                  NpcDialog.show(828,"黑暗斗魂",[[0,"我居然败了！！！这不可能！！！"]],["没有什么是不可能的"],[function():void
                  {
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     ModuleManager.showAppModule("SmallDreamBackToEarthPanel");
                     ServerMessager.addMessage("获得勇气之石~");
                  }]);
               }
            }
         }
      }
      
      private function createNPC() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(510,450));
            this._npc.resourceUrl = URLUtil.getNpcSwf(828);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.dialogShow);
         }
      }
      
      private function dialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this.isFirst == true)
         {
            NpcDialog.show(828,"黑暗斗魂",[[0,"哈哈哈哈，我——不可战胜的黑暗斗魂来啦！你们都会是我的手下败将！我要让你们都臣服于我，哈哈哈哈！"]],[" 哼，你别太得意了！"],[function():void
            {
               NpcDialog.show(766,"小梦",[[0,"小赛尔，它这么狂妄好战，会破坏这里原有的和平的！让我们一起打败它！"]],["好！"],[function():void
               {
                  NpcDialog.show(828,"黑暗斗魂",[[0,"居然真的有不怕死的家伙前来挑战！哈哈哈哈，你们将会见证自己的失败！"]],["来战！"," 我还是过会儿再来"],[function():void
                  {
                     FightManager.startFightWithWild(fightID[0]);
                  }]);
               }]);
            }]);
         }
         else
         {
            NpcDialog.show(828,"黑暗斗魂",[[0,"居然真的有不怕死的家伙前来挑战！哈哈哈哈，你们将会见证自己的失败！"]],["来战！"," 我还是过会儿再来"],[function():void
            {
               FightManager.startFightWithWild(fightID[0]);
            }]);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         RightToolbarConter.instance.show();
         StanceFightPetAct.getInstance().dispose();
      }
   }
}
