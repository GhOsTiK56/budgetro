import { ApiProperty } from '@nestjs/swagger'
import { IsEnum, IsString, Validate } from 'class-validator'

import { IdentifierValidator } from '../../../../shared/validators'

export enum IdentifierType {
	PHONE = 'phone',
	EMAIL = 'email'
}

export class SendOtpRequest {
	@ApiProperty({
		example: '+71234567890'
	})
	@IsString()
	@Validate(IdentifierValidator)
	public identifier!: string

	@ApiProperty({
		example: 'phone',
		enum: ['phone', 'email']
	})
	@IsEnum(IdentifierType)
	public type!: 'phone' | 'email'
}
