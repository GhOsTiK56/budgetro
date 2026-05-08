import { ApiProperty } from '@nestjs/swagger'

export class HealthResponse {
	@ApiProperty({
		example: 'ok'
	})
	public status: string

	@ApiProperty({
		example: '2026-05-08T09:00:03.723Z'
	})
	public timeStamp: string
}
