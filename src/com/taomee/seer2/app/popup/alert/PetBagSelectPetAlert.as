package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.events.MouseEvent;

public class PetBagSelectPetAlert extends SelectPetAlert {


    public function PetBagSelectPetAlert() {
        super();
    }

    override protected function okBtn(param1:MouseEvent):void {
        var _loc2_:uint = uint(_curtCell.name.slice(5));
        if (_loc2_ < _petInfoVec.length) {
            _pet = _petInfoVec[_loc2_];
        } else {
            _pet = null;
        }
        DisplayObjectUtil.disableButton(_confirmBtn);
        if (_confirmHandler != null) {
            _confirmHandler(_pet);
            _confirmHandler = null;
        }
        dispose();
    }
}
}
