package org.taomee.media
{
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class ListSoundPlayer
   {
       
      
      private var _player:org.taomee.media.SoundPlayer;
      
      private var _enabled:Boolean = true;
      
      private var _list:Array;
      
      private var _index:int;
      
      private var _cyc:Boolean = true;
      
      private var _invID:uint;
      
      public function ListSoundPlayer()
      {
         this._list = [];
         super();
         this._player = new org.taomee.media.SoundPlayer();
         this._player.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
      }
      
      public function destroy() : void
      {
         this._player.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         this._player.destroy();
         this._player = null;
         this._list = null;
      }
      
      public function set volume(param1:Number) : void
      {
         this._player.volume = param1;
      }
      
      public function get volume() : Number
      {
         return this._player.volume;
      }
      
      public function set cyc(param1:Boolean) : void
      {
         this._cyc = param1;
      }
      
      public function get cyc() : Boolean
      {
         return this._cyc;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         if(this._enabled)
         {
            this.play2();
         }
         else
         {
            this.stop();
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function hasURL(param1:String) : Boolean
      {
         var _loc2_:SoundInfo = null;
         for each(_loc2_ in this._list)
         {
            if(_loc2_.url == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function upDateRepInterval(param1:String, param2:Number) : void
      {
         var _loc3_:SoundInfo = null;
         for each(_loc3_ in this._list)
         {
            if(_loc3_.url == param1)
            {
               _loc3_.repInterval = param2;
            }
         }
      }
      
      public function addPlay(param1:String, param2:Number) : void
      {
         var _loc3_:SoundInfo = new SoundInfo();
         _loc3_.url = param1;
         _loc3_.repInterval = param2;
         this._list.push(_loc3_);
      }
      
      public function clear() : void
      {
         clearTimeout(this._invID);
         this._list.length = 0;
      }
      
      public function play() : void
      {
         if(this._list.length == 0)
         {
            this.stop();
         }
         if(this._enabled)
         {
            this._index = 0;
            clearTimeout(this._invID);
            this.play2();
         }
      }
      
      public function stop() : void
      {
         clearTimeout(this._invID);
         this._player.stop();
      }
      
      private function play2() : void
      {
         var _loc1_:SoundInfo = this._list[this._index];
         if(_loc1_)
         {
            if(_loc1_.url == this._player.url)
            {
               this._player.play();
            }
            else
            {
               this._player.load(_loc1_.url,true);
            }
         }
      }
      
      private function onSoundComplete(param1:Event) : void
      {
         if(!this._enabled)
         {
            return;
         }
         var _loc2_:SoundInfo = this._list[this._index];
         if(_loc2_)
         {
            if(_loc2_.repInterval > 0)
            {
               this._invID = setTimeout(this.onInvFunc,_loc2_.repInterval);
            }
            else
            {
               this.onInvFunc();
            }
         }
         else if(this._list.length > 0)
         {
            this.onInvFunc();
         }
      }
      
      private function onInvFunc() : void
      {
         ++this._index;
         if(this._index >= this._list.length)
         {
            this._index = 0;
            if(!this._cyc)
            {
               return;
            }
         }
         this.play2();
      }
   }
}

class SoundInfo
{
    
   
   public var url:String = "";
   
   public var repInterval:Number = 0;
   
   public function SoundInfo()
   {
      super();
   }
}
