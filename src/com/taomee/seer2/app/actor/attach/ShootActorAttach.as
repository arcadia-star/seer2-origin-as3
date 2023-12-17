package com.taomee.seer2.app.actor.attach
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.shoot.ShootHitEffect;
   
   public class ShootActorAttach implements IActorAttach
   {
       
      
      private var _actor:Actor;
      
      private var _effectVec:Vector.<ShootHitEffect>;
      
      public function ShootActorAttach()
      {
         super();
         this._effectVec = new Vector.<ShootHitEffect>();
      }
      
      public function attach(param1:Actor) : void
      {
         this._actor = param1;
      }
      
      public function detach() : void
      {
         var _loc1_:ShootHitEffect = null;
         for each(_loc1_ in this._effectVec)
         {
            _loc1_.dispose();
         }
         this._effectVec = null;
         this._actor = null;
      }
      
      public function excute(param1:*) : void
      {
         var _loc2_:Boolean = Boolean(param1.isAdd);
         var _loc3_:ShootHitEffect = param1.effect;
         if(_loc2_)
         {
            if(this._effectVec.length > 0 && this._effectVec[0].info.isOverlap)
            {
               this.clearEffect(this._effectVec[0]);
            }
            this._effectVec.push(_loc3_);
            this._actor.addChildAt(this._effectVec[0].stateMc,this._actor.numChildren);
         }
         else
         {
            this.clearEffect(_loc3_);
         }
      }
      
      private function clearEffect(param1:ShootHitEffect) : void
      {
         var _loc2_:int = this._effectVec.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._effectVec.splice(_loc2_,1);
            param1.dispose();
         }
      }
      
      public function get type() : String
      {
         return ActorAttachType.SHOOT;
      }
   }
}
