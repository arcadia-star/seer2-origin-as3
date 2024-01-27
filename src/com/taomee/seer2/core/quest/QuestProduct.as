package com.taomee.seer2.core.quest {
import com.taomee.seer2.core.quest.data.QuestProductDefinition;

public class QuestProduct {


    private var _definition:QuestProductDefinition;

    public function QuestProduct(param1:QuestProductDefinition) {
        super();
        this._definition = param1;
    }

    public function getReferenceIdVec():Vector.<int> {
        if (this._definition == null) {
            return null;
        }
        return this._definition.referenceIdVec;
    }

    public function getQuantityVec():Vector.<int> {
        if (this._definition == null) {
            return null;
        }
        return this._definition.quantityVec;
    }

    public function getIsPetVec():Vector.<Boolean> {
        if (this._definition == null) {
            return null;
        }
        return this._definition.isPetVec;
    }
}
}
