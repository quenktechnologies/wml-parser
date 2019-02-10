
import * as ___wml from '../../src';




export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.node('p', {html : { 'class' : concat  ([x,___wml.read < string  >(`ww:class`, someValue ),___wml.read < string  >(`ww:variant`, some.other.value  ,`default`)])  } ,wml : {  } }, [], ___view) ;

       }

     }

