package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80080 extends MapProcessor
   {
      
      private static const FIGHT_INDEX:int = 715;
       
      
      private var _npc:Mobile;
      
      public function MapProcessor_80080(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
         {
            TweenNano.delayedCall(3,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
            return;
         }
         this._npc = MobileManager.getMobile(660,MobileType.NPC);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(660,"巨石托尔",[[0,"你是我的过去，我是你的未来。你一定会成为我，来，战一场！"]],["接受挑战","准备一下"],[function():void
         {
            FightManager.startFightWithWild(FIGHT_INDEX);
         }]);
      }
      
      override public function dispose() : void
      {
         this.clearNpc();
         super.dispose();
      }
   }
}
