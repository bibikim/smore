package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.jobs.JobsDTO;

@Mapper
public interface JobsMapper {
	public int selectListCount();
	public List<JobsDTO> selectJobsListByMap(Map<String, Object> map);
	public JobsDTO selectJobsByNo(int jobNo);
	public int insertJobs(JobsDTO job);
	public int updateHit(int jobNo);
	public int modifyJobs(JobsDTO job);
	public int deleteJobs(int jobNo);
	public int updateStatus(int jobNo);  // 채용완료
}
