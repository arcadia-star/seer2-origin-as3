package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80408 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [205684];
      
      private static const DAY_LIST:Array = [1645];
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1518,1519,1520]);
      
      private static const RES_LIST:Vector.<int> = Vector.<int>([113,187,137]);
      
      private static const LEVEL_LIST:Vector.<int> = Vector.<int>([20,60,100]);
      
      private static const FIGHT_NUM_RULE:int = 5;
       
      
      private var _npc:SpawnedPet;
      
      private var _curIndex:int;
      
      public function MapProcessor_80408(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.onActInit();
      }
      
      private function onActInit() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FIGHT_INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
         {
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
               {
                  var info:DayLimitListInfo = param1;
                  var canFightNum:int = FIGHT_NUM_RULE - info.getCount(DAY_LIST[0]) >= 0 ? FIGHT_NUM_RULE - info.getCount(DAY_LIST[0]) : 0;
                  if(par.infoVec[0] >= 20)
                  {
                     ServerMessager.addMessage("已获得足够的尘之力了哦!");
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     TweenNano.delayedCall(2,function():void
                     {
                        ModuleManager.showAppModule("WorldKingTwoPanel");
                     });
                  }
                  else if(canFightNum > 0)
                  {
                     initAct();
                  }
                  else
                  {
                     ServerMessager.addMessage("今日免费挑战次数已用完！");
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     TweenNano.delayedCall(2,function():void
                     {
                        ModuleManager.showAppModule("WorldKingTwoGetPowerPanel");
                     });
                  }
               });
            });
         }
         else
         {
            this.initAct();
         }
      }
      
      private function initAct() : void
      {
         this.createNpc();
      }
      
      private function onActDispose() : void
      {
         this.clearNpc();
      }
      
      private function createNpc() : void
      {
         var _loc1_:int = 0;
         if(!this._npc)
         {
            _loc1_ = ActsHelperUtil.getRandom(0,100);
            if(_loc1_ >= 0 && _loc1_ <= 30)
            {
               this._curIndex = 0;
            }
            else if(_loc1_ > 30 && _loc1_ <= 80)
            {
               this._curIndex = 1;
            }
            else
            {
               this._curIndex = 2;
            }
            this._npc = new SpawnedPet(RES_LIST[this._curIndex],FIGHT_INDEX_LIST[this._curIndex],LEVEL_LIST[this._curIndex]);
            this._npc.setPostion(new Point(460,400));
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.SPAWNED_PET);
         }
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
