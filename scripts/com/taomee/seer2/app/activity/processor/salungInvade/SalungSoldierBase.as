package com.taomee.seer2.app.activity.processor.salungInvade
{
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class SalungSoldierBase extends Sprite
   {
      
      protected static const MAP_OOSITION:Object = {
         "m_141":[333,466],
         "m_110":[239,408],
         "m_180":[506,288],
         "m_201":[326,378],
         "m_240":[156,295],
         "m_261":[157,428]
      };
       
      
      protected var _info:ContentInfo;
      
      protected var _mapId:uint;
      
      protected var _mc:MovieClip;
      
      protected var _npc:MovieClip;
      
      protected var _helpMc:MovieClip;
      
      public function SalungSoldierBase(param1:uint = 0)
      {
         super();
         this._mapId = param1;
      }
      
      protected function loadRes(param1:String) : void
      {
         if(!this._info)
         {
            QueueLoader.load(URLUtil.getActivityAnimation(param1),LoadType.SWF,this.onResLoaded);
         }
         else
         {
            this.onResLoaded();
         }
      }
      
      protected function initNpc() : void
      {
         if(this._mapId == 0)
         {
            this.initGame(null);
            return;
         }
         this._npc = new (this._info.domain.getDefinition("npcMc"))();
         LayerManager.uiLayer.addChild(this._npc);
         this._npc.addEventListener(MouseEvent.CLICK,this.showHelpDialog);
         this._npc.x = MAP_OOSITION["m_" + this._mapId][0];
         this._npc.y = MAP_OOSITION["m_" + this._mapId][1];
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.removeNpc);
      }
      
      protected function showHelpDialog(param1:MouseEvent = null) : void
      {
         this._helpMc = new (this._info.domain.getDefinition("helpMc"))();
         this._helpMc.x = 338.1;
         this._helpMc.y = 156.9;
         LayerManager.topLayer.addChild(this._helpMc);
         LayerManager.focusOnTopLayer();
         this._helpMc["beginBtn"].addEventListener(MouseEvent.CLICK,this.beginGame);
         this._helpMc["closeBtn"].addEventListener(MouseEvent.CLICK,this.giveUpGame);
      }
      
      private function beginGame(param1:MouseEvent) : void
      {
         this._helpMc["beginBtn"].removeEventListener(MouseEvent.CLICK,this.beginGame);
         this._helpMc["closeBtn"].removeEventListener(MouseEvent.CLICK,this.beginGame);
         DisplayUtil.removeForParent(this._helpMc);
         LayerManager.resetOperation();
         this.initGame(null);
      }
      
      private function giveUpGame(param1:MouseEvent) : void
      {
         this._helpMc["beginBtn"].removeEventListener(MouseEvent.CLICK,this.beginGame);
         this._helpMc["closeBtn"].removeEventListener(MouseEvent.CLICK,this.beginGame);
         DisplayUtil.removeForParent(this._helpMc);
         LayerManager.resetOperation();
      }
      
      protected function initGame(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._npc);
         LayerManager.hideMap();
      }
      
      protected function removeNpc(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.removeNpc);
         DisplayUtil.removeForParent(this._npc);
      }
      
      protected function onResLoaded(param1:ContentInfo = null) : void
      {
         if(this._mapId != 0 && SceneManager.active.mapID != this._mapId)
         {
            return;
         }
         if(this._info == null)
         {
            this._info = param1;
         }
         this.initUI();
      }
      
      public function dispose() : void
      {
         LayerManager.showMap();
      }
      
      protected function getAward() : void
      {
         SwapManager.swapItem(547,1,function(param1:IDataInput):void
         {
            var _loc2_:SwapInfo = new SwapInfo(param1);
         });
      }
      
      protected function initUI() : void
      {
      }
   }
}
