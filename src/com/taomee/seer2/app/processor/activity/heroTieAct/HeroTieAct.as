package com.taomee.seer2.app.processor.activity.heroTieAct
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class HeroTieAct
   {
      
      private static const FOR_LIST:Array = [204649];
      
      private static const DAY_LIST:Array = [1302,1301,1304];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3120]);
      
      private static const MAP_LIST:Vector.<int> = Vector.<int>([160,90,230,470,320,40,80,50]);
      
      private static const POS:Vector.<Point> = Vector.<Point>([new Point(200,300),new Point(220,300),new Point(270,300),new Point(260,455),new Point(750,300),new Point(300,300),new Point(300,300),new Point(300,300)]);
      
      private static const TIME:int = 180;
       
      
      private var _resLib:ApplicationDomain;
      
      private var _mapModel:MapModel;
      
      private var _tie:MovieClip;
      
      private var _getAward:SimpleButton;
      
      private var _goAct:SimpleButton;
      
      private var _info:DayLimitListInfo;
      
      private var _par:Parser_1142;
      
      private var _curIndex:int;
      
      public function HeroTieAct(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.getURL();
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("heroTieAct/HeroTieAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private function init() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _info = param1;
               _par = par;
               if(_par.infoVec[0] != 7)
               {
                  addTieNpc();
               }
            });
         });
      }
      
      private function updateData() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _info = param1;
               _par = par;
            });
         });
      }
      
      private function addTieNpc() : void
      {
         this._tie = this.getMovie("TieNpc");
         this._tie.scaleX = this._tie.scaleY = 0.72;
         this._tie.buttonMode = true;
         this._getAward = this._tie["getAward"];
         this._goAct = this._tie["goAct"];
         this._mapModel.content.addChild(this._tie);
         this._curIndex = MAP_LIST.indexOf(this._mapModel.id);
         this._tie.x = POS[this._curIndex].x;
         this._tie.y = POS[this._curIndex].y;
         this._getAward.addEventListener(MouseEvent.CLICK,this.onTieClick);
         this._goAct.addEventListener(MouseEvent.CLICK,this.onGoAct);
      }
      
      private function onGoAct(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("OpenTiePanel");
      }
      
      private function onTieClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._info.getCount(DAY_LIST[0]) == 0)
         {
            AlertManager.showAlert("今天还没有揭榜哦，快接榜吧!",function():void
            {
               ModuleManager.showAppModule("OpenTiePanel");
            });
         }
         else
         {
            if(BitUtil.getBit(this._info.getCount(DAY_LIST[1]),this._curIndex))
            {
               AlertManager.showAlert("你今天已经拿的够多了哦，去别的地方试试、或者明天再来吧。");
               return;
            }
            if(ActorManager.actorInfo.activityData[11] < TIME)
            {
               AlertManager.showAlert("领取时间还没到哦!");
               return;
            }
            SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
            {
               var sceneMC:MovieClip = null;
               var data:IDataInput = param1;
               _tie.visible = false;
               updateData();
               sceneMC = getMovie("HeroSceneMC");
               sceneMC.x = 660;
               sceneMC.y = 370;
               _mapModel.front.addChild(sceneMC);
               MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMC);
                  new SwapInfo(data);
                  sceneMC = null;
                  _tie.visible = true;
               },true);
            },null,new SpecialInfo(1,this._curIndex));
         }
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      public function dispose() : void
      {
         this._resLib = null;
         this._mapModel = null;
         if(this._getAward)
         {
            this._getAward.removeEventListener(MouseEvent.CLICK,this.onTieClick);
            this._getAward = null;
         }
         if(this._goAct)
         {
            this._goAct.removeEventListener(MouseEvent.CLICK,this.onGoAct);
            this._goAct = null;
         }
         this._tie = null;
      }
   }
}
