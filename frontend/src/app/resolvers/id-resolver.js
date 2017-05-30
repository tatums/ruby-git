import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot } from '@angular/router';

@Injectable()

export class IdResolver {

  resolve(route: ActivatedRouteSnapshot) {
    return route.params.id
  }
}

