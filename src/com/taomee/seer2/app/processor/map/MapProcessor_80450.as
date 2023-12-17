package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_80450 extends MapProcessor
   {
      
      public static var gameHandleState:int;
      
      private static var _playState:Vector.<int> = Vector.<int>([0,0,0]);
      
      private static const GO_LIST:Array = ["MiKaAwakenGameOneTipPanel","MiKaAwakenGameTwoPanel","MiKaAwakenGameThreePanel"];
       
      
      private var _resLib:ApplicationDomain;
      
      private var _sceneMc:MovieClip;
      
      private var _curGameIndex:int;
      
      public function MapProcessor_80450(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.hideLobbyMenu();
         if(gameHandleState > 0)
         {
            if(_playState[gameHandleState - 1])
            {
               this.startGame();
            }
            else
            {
               this.getURL(function():void
               {
                  _sceneMc = getMovie("SceneMc" + gameHandleState);
                  _map.front.addChild(_sceneMc);
                  MovieClipUtil.playMc(_sceneMc,2,_sceneMc.totalFrames,function():void
                  {
                     _playState[gameHandleState - 1] = 1;
                     _sceneMc.gotoAndStop(1);
                     DisplayUtil.removeForParent(_sceneMc);
                     _sceneMc = null;
                     startGame();
                  },true);
               });
            }
         }
      }
      
      private function getURL(param1:Function = null) : void
      {
         var callBack:Function = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("miKaAwakenAct/MiKaAwakenAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            if(callBack != null)
            {
               callBack();
            }
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function startGame() : void
      {
         ActsHelperUtil.goHandle(GO_LIST[gameHandleState - 1]);
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      override public function dispose() : void
      {
         gameHandleState = 0;
         this._sceneMc = null;
         super.dispose();
      }
   }
}
