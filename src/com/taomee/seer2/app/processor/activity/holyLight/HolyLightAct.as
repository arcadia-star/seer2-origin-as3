package com.taomee.seer2.app.processor.activity.holyLight
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.grids.HashMap;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class HolyLightAct
   {
       
      
      private const LIGHT_DAYLIMIT:int = 616;
      
      private var _resLib:ApplicationDomain;
      
      private var _map:MapModel;
      
      private var _resHash:HashMap;
      
      public function HolyLightAct(param1:MapModel)
      {
         super();
         this._map = param1;
         this._resHash = new HashMap();
         if(this.isInActTime())
         {
            this.addListener();
            this.getURL();
         }
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("holyLight/HolyLight"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private function init() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.HOLY_LIGHT,this.onGetServer,false);
      }
      
      private function initHandle() : void
      {
         this._resHash = new HashMap();
         this.showSelf();
      }
      
      private function addListener() : void
      {
         Connection.addCommandListener(CommandSet.LIST_USER_1004,this.listUsers);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,this.addUser);
         Connection.addCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151,this.onBroadCast);
      }
      
      private function removeListener() : void
      {
         Connection.removeCommandListener(CommandSet.LIST_USER_1004,this.listUsers);
         Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002,this.addUser);
         Connection.removeCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151,this.onBroadCast);
      }
      
      private function onGetServer(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var mark:int = server.readDataAtPostion(1);
         if(mark == 0)
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("holyLight/Holy_2"),function():void
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.HOLY_LIGHT,1,1);
               initHandle();
            },true,true);
         }
         else
         {
            this.initHandle();
         }
      }
      
      private function onBroadCast(param1:MessageEvent) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:RemoteActor = null;
         if(SceneManager.active.mapID != 1301)
         {
            return;
         }
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_ == 5)
            {
               _loc6_ = uint(_loc2_.readUnsignedInt());
               _loc7_ = uint(_loc2_.readUnsignedInt());
               if(ActorManager.actorInfo.id == _loc6_)
               {
                  if(_loc7_ > 0)
                  {
                     if(!this._resHash.containsKey(_loc6_))
                     {
                        _loc8_ = this.getMovie("HolyLight");
                        this._resHash.put(_loc6_,_loc8_);
                        if(_loc8_ == null)
                        {
                           TweenNano.delayedCall(5,this.onAddHoly,[DisplayObjectContainer(ActorManager.getActor().animation),_loc8_]);
                        }
                        else
                        {
                           _loc8_.x = -_loc8_.width / 2;
                           _loc8_.y = -130;
                           DisplayObjectContainer(ActorManager.getActor().animation).addChild(_loc8_);
                        }
                     }
                  }
                  else
                  {
                     DisplayUtil.removeForParent(this._resHash.getValue(_loc6_) as MovieClip);
                     this._resHash.remove(_loc6_);
                  }
               }
               else if(_loc9_ = ActorManager.getRemoteActor(_loc6_))
               {
                  if(_loc7_ > 0)
                  {
                     if(!this._resHash.containsKey(_loc6_))
                     {
                        _loc8_ = this.getMovie("HolyLight");
                        this._resHash.put(_loc6_,_loc8_);
                        if(_loc8_ == null)
                        {
                           TweenNano.delayedCall(5,this.onAddHoly,[DisplayObjectContainer(_loc9_.animation),_loc8_]);
                        }
                        else
                        {
                           _loc8_.x = -_loc8_.width / 2;
                           _loc8_.y = -130;
                           DisplayObjectContainer(_loc9_.animation).addChild(_loc8_);
                        }
                     }
                  }
                  else
                  {
                     DisplayUtil.removeForParent(this._resHash.getValue(_loc6_) as MovieClip);
                     this._resHash.remove(_loc6_);
                  }
               }
            }
            _loc5_++;
         }
      }
      
      private function actTimeValidate(param1:int) : void
      {
         var n:int = param1;
         if(!this.isInActTime())
         {
            Tick.instance.removeRender(this.actTimeValidate);
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("holyLight/Holy_3"),function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
      }
      
      private function listUsers(param1:MessageEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:RemoteActor = null;
         if(SceneManager.active.mapID != 1301)
         {
            return;
         }
         var _loc2_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.getInfo().activityData[3] > 0)
            {
               _loc3_ = this.getMovie("HolyLight");
               this._resHash.put(_loc4_.getInfo().id,_loc3_);
               if(_loc3_ == null)
               {
                  TweenNano.delayedCall(3,this.onAddHoly,[DisplayObjectContainer(_loc4_.animation),_loc3_]);
               }
               else
               {
                  _loc3_.x = -_loc3_.width / 2;
                  _loc3_.y = -130;
                  DisplayObjectContainer(_loc4_.animation).addChild(_loc3_);
               }
            }
         }
      }
      
      private function onAddHoly(param1:DisplayObjectContainer, param2:MovieClip) : void
      {
         var _loc3_:DisplayObjectContainer = param1;
         var _loc4_:MovieClip = param2;
         if(_loc4_ = this.getMovie("HolyLight"))
         {
            _loc4_.x = -_loc4_.width / 2;
            _loc4_.y = -130;
            _loc3_.addChild(_loc4_);
         }
         else
         {
            TweenNano.delayedCall(2,this.onAddHoly,[_loc3_,_loc4_]);
         }
      }
      
      private function showSelf() : void
      {
         DayLimitManager.getDoCount(this.LIGHT_DAYLIMIT,function(param1:int):void
         {
            var _loc2_:MovieClip = null;
            if(param1 < 50)
            {
               _loc2_ = getMovie("HolyLight");
               _resHash.put(ActorManager.getActor().id,_loc2_);
               _loc2_.x = -_loc2_.width / 2;
               _loc2_.y = -130;
               DisplayObjectContainer(ActorManager.getActor().animation).addChild(_loc2_);
            }
         });
      }
      
      private function removeSelf() : void
      {
         var _loc1_:MovieClip = this._resHash.getValue(ActorManager.getActor().id) as MovieClip;
         if(_loc1_)
         {
            DisplayUtil.removeForParent(_loc1_);
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
      
      private function addUser(param1:MessageEvent) : void
      {
         var _loc5_:MovieClip = null;
         if(SceneManager.active.mapID != 1301)
         {
            return;
         }
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:RemoteActor;
         if(_loc4_ = ActorManager.getRemoteActor(_loc3_))
         {
            if(_loc4_.getInfo().activityData[3] > 0)
            {
               _loc5_ = this.getMovie("HolyLight");
               this._resHash.put(_loc4_.getInfo().id,_loc5_);
               if(_loc5_ == null)
               {
                  TweenNano.delayedCall(5,this.onAddHoly,[DisplayObjectContainer(_loc4_.animation),_loc5_]);
               }
               else
               {
                  _loc5_.x = -_loc5_.width / 2;
                  _loc5_.y = -130;
                  DisplayObjectContainer(_loc4_.animation).addChild(_loc5_);
               }
            }
         }
      }
      
      private function isInActTime() : Boolean
      {
         var _loc1_:Boolean = false;
         return true;
      }
      
      public function dispose() : void
      {
         this.removeSelf();
         this._resHash.clear();
         this.removeListener();
      }
   }
}
