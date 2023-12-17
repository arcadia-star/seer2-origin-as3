package com.taomee.seer2.app.processor.activity.leiYiWingFirstComeAct
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class LeiYiWingFirstComeAct
   {
      
      private static var _pieceList:Vector.<MovieClip>;
      
      private static var _scene0:MovieClip;
      
      private static var _npc:MovieClip;
      
      private static var _cdTimeTxt:TextField;
      
      private static const FOR_LIST:Array = [205936,205945];
      
      private static const GET_SWAP:int = 4126;
      
      private static const MAP_LIST:Vector.<int> = Vector.<int>([80480]);
      
      public static var isNewStart:Boolean = false;
      
      private static var _resLib:ApplicationDomain;
      
      private static var _curIndex:int;
      
      private static var _leaveTime:int;
       
      
      public function LeiYiWingFirstComeAct()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onStart);
      }
      
      private static function onStart(param1:SceneEvent) : void
      {
         if(_resLib)
         {
            dispose();
         }
      }
      
      private static function onComplete(param1:SceneEvent) : void
      {
         _curIndex = MAP_LIST.indexOf(SceneManager.active.mapID);
         if(_curIndex != -1)
         {
            getURL();
         }
      }
      
      private static function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("LeiYiWingFirstComeAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private static function getMovie(param1:String) : MovieClip
      {
         if(_resLib)
         {
            return DomainUtil.getMovieClip(param1,_resLib);
         }
         return null;
      }
      
      private static function init() : void
      {
         _npc = getMovie("Npc");
         _cdTimeTxt = _npc["cdTimeTxt"] as TextField;
         if(isNewStart)
         {
            isNewStart = false;
            _scene0 = getMovie("SceneMc0");
            _scene0.x = 0;
            _scene0.y = 0;
            _scene0.buttonMode = true;
            SceneManager.active.mapModel.front.addChild(_scene0);
            MovieClipUtil.playMc(_scene0,2,_scene0.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_scene0);
               _scene0 = null;
               update();
            });
         }
         else
         {
            update();
         }
      }
      
      private static function onScene0Click(param1:MouseEvent) : void
      {
         _scene0.removeEventListener(MouseEvent.CLICK,onScene0Click);
      }
      
      private static function update() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var _loc2_:MovieClip = null;
            var _loc3_:int = 0;
            Tick.instance.removeRender(onCdUpdate);
            if(param1.infoVec[1] == 0)
            {
               dispose();
            }
            else if(TimeManager.getPrecisionServerTime() > param1.infoVec[0] + 60)
            {
               dispose();
            }
            else
            {
               SceneManager.active.mapModel.content.addChild(_npc);
               _npc.x = 780;
               _npc.y = 20;
               _leaveTime = param1.infoVec[0] + 60 - TimeManager.getPrecisionServerTime();
               _cdTimeTxt.text = DateUtil.getMS(_leaveTime);
               Tick.instance.addRender(onCdUpdate,1000);
               disposePiece();
               _pieceList = new Vector.<MovieClip>();
               _loc3_ = 0;
               while(_loc3_ < param1.infoVec[1])
               {
                  _loc2_ = getMovie("Piece");
                  _loc2_.x = ActsHelperUtil.getRandom(220,990);
                  _loc2_.y = ActsHelperUtil.getRandom(210,530);
                  _loc2_.buttonMode = true;
                  SceneManager.active.mapModel.front.addChild(_loc2_);
                  _pieceList.push(_loc2_);
                  _loc2_.addEventListener(MouseEvent.CLICK,onPieceClick);
                  _loc3_++;
               }
            }
         });
      }
      
      private static function onPieceClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var evt:MouseEvent = param1;
         index = _pieceList.indexOf(evt.currentTarget as MovieClip);
         setPieceMouseEnable(false);
         SwapManager.swapItem(GET_SWAP,1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            DisplayUtil.removeForParent(_pieceList[index]);
            _pieceList.splice(index,1);
            setPieceMouseEnable(true);
            if(_pieceList.length == 0)
            {
               dispose();
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(2,function():void
               {
                  ModuleManager.showAppModule("LeiYiWingFirstComePanel");
               });
            }
         },function(param1:uint):void
         {
            setPieceMouseEnable(true);
         });
      }
      
      private static function setPieceMouseEnable(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in _pieceList)
         {
            _loc2_.mouseEnabled = _loc2_.mouseChildren = param1;
         }
      }
      
      private static function onCdUpdate(param1:int) : void
      {
         var val:int = param1;
         --_leaveTime;
         _cdTimeTxt.text = DateUtil.getMS(_leaveTime);
         if(_leaveTime <= 0)
         {
            dispose();
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(2,function():void
            {
               ModuleManager.showAppModule("LeiYiWingFirstComePanel");
            });
         }
      }
      
      private static function disposeSceneMC() : void
      {
         if(_scene0)
         {
            _scene0.removeEventListener(MouseEvent.CLICK,onScene0Click);
            DisplayUtil.removeForParent(_scene0);
            _scene0 = null;
         }
      }
      
      private static function disposeMika() : void
      {
         Tick.instance.removeRender(onCdUpdate);
         if(_npc)
         {
            DisplayUtil.removeForParent(_npc);
            _npc = null;
         }
      }
      
      private static function disposePiece() : void
      {
         var _loc1_:int = 0;
         if(_pieceList)
         {
            _loc1_ = 0;
            while(_loc1_ < _pieceList.length)
            {
               _pieceList[_loc1_].removeEventListener(MouseEvent.CLICK,onPieceClick);
               DisplayUtil.removeForParent(_pieceList[_loc1_]);
               _loc1_++;
            }
            _pieceList = null;
         }
      }
      
      private static function dispose() : void
      {
         disposeSceneMC();
         disposeMika();
         disposePiece();
      }
   }
}
