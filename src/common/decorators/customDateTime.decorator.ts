import {
  registerDecorator,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from 'class-validator';

@ValidatorConstraint({ async: false })
export class IsCustomDateConstraint implements ValidatorConstraintInterface {
  validate(dateString: any) {
    const dateRegex = /^\d{2}\.\d{2}\.\d{4}$/;
    if (!dateRegex.test(dateString)) {
      return false;
    }

    const [day, month, year] = dateString.split('.').map(Number);
    const date = new Date(year, month - 1, day);
    return !isNaN(date.getTime());
  }

  defaultMessage() {
    return 'Date must be in the format dd.mm.yyyy';
  }
}

@ValidatorConstraint({ async: false })
export class IsCustomTimeConstraint implements ValidatorConstraintInterface {
  validate(timeString: any) {
    const timeRegex = /^\d{2}:\d{2}$/;
    if (!timeRegex.test(timeString)) {
      return false;
    }

    const [hours, minutes] = timeString.split(':').map(Number);
    if (hours < 0 || hours >= 24 || minutes < 0 || minutes >= 60) {
      return false;
    }

    return true;
  }

  defaultMessage() {
    return 'Time must be in the format hh:mm';
  }
}

export function IsCustomDate(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      constraints: [],
      validator: IsCustomDateConstraint,
    });
  };
}

export function IsCustomTime(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      constraints: [],
      validator: IsCustomTimeConstraint,
    });
  };
}
