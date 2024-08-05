package com.dkitec.barocle.logging;

public class LogRepository {

	private static ThreadLocal<Log> logRepo;

	static {
		logRepo = new ThreadLocal<Log>();
	}

	public static void setLog(Log log) {

		logRepo.set(log);
	}

	public static Log getLog() {

		return logRepo.get();
	}

	public static void removeLog() {

		logRepo.remove();
	}
}
