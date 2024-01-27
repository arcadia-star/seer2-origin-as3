package com.taomee.seer2.core.camera {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.DisplayObject;
import flash.geom.Rectangle;

public class Camera {

    private static const OFFSET_X:int = 250;

    private static const OFFSET_Y:int = 150;


    private var _trackTarget:DisplayObject;

    private var _sceneBoundary:Rectangle;

    private var _viewport:Rectangle;

    private var _trackRect:Rectangle;

    public function Camera(param1:Number, param2:Number) {
        super();
        this._viewport = new Rectangle(0, 0, param1, param2);
        this._trackRect = new Rectangle(0, 0, param1 - 2 * OFFSET_X, param2 - 2 * OFFSET_Y);
    }

    public function setTrackTarget(param1:DisplayObject):void {
        this._trackTarget = param1;
    }

    public function getTrackTarget():DisplayObject {
        return this._trackTarget;
    }

    public function setSceneBoundary(param1:Rectangle):void {
        this._sceneBoundary = param1;
        this._viewport.x = 0;
        this._viewport.y = 0;
    }

    public function update():void {
        if (this._trackTarget == null) {
            return;
        }
        this._trackRect.x = this._viewport.x + OFFSET_X;
        this._trackRect.y = this._viewport.y + OFFSET_Y;
        if (this._trackRect.contains(this._trackTarget.x, this._trackTarget.y)) {
            return;
        }
        var _loc1_:Number = this._viewport.x;
        var _loc2_:Number = this._viewport.y;
        if (this._trackTarget.x < this._trackRect.left) {
            this._viewport.x -= this._trackRect.left - this._trackTarget.x;
        } else if (this._trackTarget.x > this._trackRect.right) {
            this._viewport.x += this._trackTarget.x - this._trackRect.right;
        }
        if (this._trackTarget.y < this._trackRect.top) {
            this._viewport.y -= this._trackRect.top - this._trackTarget.y;
        } else if (this._trackTarget.y > this._trackRect.bottom) {
            this._viewport.y += this._trackTarget.y - this._trackRect.bottom;
        }
        if (this._viewport.x < 0) {
            this._viewport.x = 0;
        } else if (this._viewport.x + this._viewport.width > this._sceneBoundary.width) {
            this._viewport.x = this._sceneBoundary.width - this._viewport.width;
        }
        if (this._viewport.y < 0) {
            this._viewport.y = 0;
        } else if (this._viewport.y + this._viewport.height > this._sceneBoundary.height) {
            this._viewport.y = this._sceneBoundary.height - this._viewport.height;
        }
        if (_loc1_ != this._viewport.x || _loc2_ != this._viewport.y) {
            LayerManager.mapLayer.scrollRect = this._viewport;
        }
    }
}
}
