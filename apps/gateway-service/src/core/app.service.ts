import { Injectable } from '@nestjs/common'

@Injectable()
export class AppService {
	public getHello() {
		return { message: 'Hello World!' }
	}

	public health() {
		return { status: 'ok', timestamp: new Date().toISOString() }
	}
}
