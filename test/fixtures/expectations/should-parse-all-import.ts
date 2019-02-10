
import * as ___wml from '../../src';
import * as lib  from 'path/to/libs'; 



export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.node('tag', {html : {  } ,wml : {  } }, [], ___view) ;

       }

     }

