package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80125 extends FeiyuyiteMap
   {
      
      private static const NpcIds:Vector.<int> = Vector.<int>([3113]);
      
      private static const FightIds:Vector.<int> = Vector.<int>([1816]);
      
      private static const Positions:Vector.<Point> = Vector.<Point>([new Point(642,272)]);
       
      
      private var timeIndex:Array;
      
      private var index:int;
      
      private const FIGHT_ID:Array = [1841,1842];
      
      private var _petBagBtn:SimpleButton;
      
      private var _mobiles:Vector.<Mobile>;
      
      public function MapProcessor_80125(param1:MapModel)
      {
         this.timeIndex = [0,3,6];
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function init() : void
      {
         this.hideLobbyMenu();
         this._mobiles = new Vector.<Mobile>();
         this._mobiles.push(new Mobile());
         FightManager.addEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
         super.init();
      }
      
      private function overHandler(param1:FightStartEvent) : void
      {
         this.resultFunc();
      }
      
      private function resultFunc() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
         FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
         SceneManager.changeScene(SceneType.LOBBY,70);
         TweenNano.delayedCall(1,function():void
         {
            ModuleManager.showAppModule("StarShadowPanel");
         });
      }
      
      private function _petBagHandler(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._petBagBtn.visible = false;
         NpcDialog.show(400,"小赛尔",[[0,"母船探测到的奇异的引力波讯号就是来自于这里了……好像没什么异样……咦，这是什么？"]],["（拾起星屑）"],[function():void
         {
            SwapManager.swapItem(4580,1,function success(param1:IDataInput):void
            {
               new SwapInfo(param1);
            });
         }]);
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
   }
}
