package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.preview.ActorPreview;
   import com.taomee.seer2.app.config.MonthRankFixConfig;
   import com.taomee.seer2.app.manager.RankManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
   import com.taomee.seer2.app.net.parser.Parser_1521;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapProcessor_3832 extends MapProcessor
   {
      
      private static const POS:Vector.<Point> = Vector.<Point>([new Point(390,425),new Point(820,425),new Point(600,425)]);
       
      
      private var _actorPreviewList:Vector.<ActorPreview>;
      
      private var _winerNamList:Vector.<TextField>;
      
      private var _curWin:Vector.<uint>;
      
      private var _callBack:Function;
      
      public function MapProcessor_3832(param1:MapModel)
      {
         super(param1);
      }
      
      private function getStartAndEndTime() : Vector.<uint>
      {
         var _loc1_:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
         var _loc2_:uint = _loc1_.getTime() / 1000;
         var _loc3_:int = _loc1_.day == 0 ? 7 : int(_loc1_.day);
         var _loc4_:uint = (_loc3_ - 1) * 86400 + _loc1_.hours * 3600 + _loc1_.minutes * 60 + _loc1_.minutes + 600;
         var _loc5_:uint;
         var _loc6_:uint = uint((_loc5_ = uint(_loc2_ - _loc4_)) - 604800 + 700);
         var _loc7_:Vector.<uint>;
         (_loc7_ = Vector.<uint>([])).push(_loc6_);
         _loc7_.push(_loc5_);
         return _loc7_;
      }
      
      override public function init() : void
      {
         var i:int;
         var actor:ActorPreview = null;
         var timeLimit:Vector.<uint> = null;
         super.init();
         this._curWin = Vector.<uint>([]);
         _map.content["mc0"].addEventListener(MouseEvent.CLICK,this.onClick);
         this._actorPreviewList = Vector.<ActorPreview>([]);
         this._winerNamList = new Vector.<TextField>();
         i = 0;
         while(i < 3)
         {
            this._winerNamList.push(_map.content["winerNam" + i]);
            this._winerNamList[i].text = "";
            actor = new ActorPreview();
            actor.scaleX = actor.scaleY = 0.4;
            actor.x = POS[i].x;
            actor.y = POS[i].y;
            _map.content.addChild(actor);
            this._actorPreviewList.push(actor);
            i++;
         }
         timeLimit = this.getStartAndEndTime();
         MonthRankFixConfig.Instance.getInfo(function():void
         {
            getRankVal(MonthRankFixConfig.Instance.getListIDFromDate(1),timeLimit,function(param1:uint):void
            {
               var userId:uint = param1;
               _curWin.push(userId);
               getRankVal(MonthRankFixConfig.Instance.getListIDFromDate(2),timeLimit,function(param1:uint):void
               {
                  var userId:uint = param1;
                  _curWin.push(userId);
                  getRankVal(MonthRankFixConfig.Instance.getListIDFromDate(3),timeLimit,function(param1:uint):void
                  {
                     var userId:uint = param1;
                     _curWin.push(userId);
                     requestUserInfo(_curWin[0],function(param1:UserInfo):void
                     {
                        var info:UserInfo = param1;
                        if(info != null)
                        {
                           _actorPreviewList[0].setData(info);
                           _winerNamList[0].text = info.nick;
                        }
                        requestUserInfo(_curWin[1],function(param1:UserInfo):void
                        {
                           var info:UserInfo = param1;
                           if(info != null)
                           {
                              _actorPreviewList[1].setData(info);
                              _winerNamList[1].text = info.nick;
                           }
                           requestUserInfo(_curWin[2],function(param1:UserInfo):void
                           {
                              if(param1 != null)
                              {
                                 _actorPreviewList[2].setData(param1);
                                 _winerNamList[2].text = param1.nick;
                              }
                           });
                        });
                     });
                  });
               });
            });
         });
      }
      
      private function getRankVal(param1:uint, param2:Vector.<uint>, param3:Function = null) : void
      {
         var rankType:uint = param1;
         var timeLimit:Vector.<uint> = param2;
         var callBack:Function = param3;
         RankManager.getBeforeRank(rankType,function getRank(param1:Parser_1521):void
         {
            if(callBack != null)
            {
               if(param1.rankInfoList.length < 1)
               {
                  callBack(0);
               }
               else
               {
                  callBack(param1.rankInfoList[0].userId);
               }
            }
         },0,0,timeLimit[0],timeLimit[1]);
      }
      
      private function requestUserInfo(param1:uint, param2:Function = null) : void
      {
         this._callBack = param2;
         if(param1 > 0)
         {
            Connection.addCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010,this.onGetDetailInfo);
            Connection.send(CommandSet.USER_GET_DETAIL_INFO_1010,param1);
         }
         else if(this._callBack != null)
         {
            this._callBack(null);
         }
      }
      
      private function onGetDetailInfo(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         Connection.removeCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010,this.onGetDetailInfo);
         ByteArray(_loc2_).position = 0;
         var _loc4_:UserInfo = new UserInfo();
         UserInfoParseHelper.parseUserDetailInfo(_loc4_,_loc2_);
         if(this._callBack != null)
         {
            this._callBack(_loc4_);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("SpaceAltrlMainPanel"),"打开保护的挑战面板...");
      }
   }
}
