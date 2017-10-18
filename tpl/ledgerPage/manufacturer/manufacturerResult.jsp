<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table id="result_table" class="table table-striped b-t b-light">
	<thead>
		<tr>
			<th style="width: 20px;">
				<label class="i-checks m-b-none">
					<input type="checkbox" id="all"
			onclick="changeAll(this.checked,'ids');" /><i></i>
				</label>
			</th>
			<th>厂商编号</th>
			<th>厂商名称</th>
			<th>企业规模</th>
			<th>市场地位</th>
			<th>企业法人</th>
			<th>注册资金(万元)</th>
			<th>操作</th>
			
		</tr>
	</thead>
	<tbody role="alert" aria-live="polite" aria-relevant="all">
		
				<tr  ng-repeat="vo in items ">
					<td>
					<label class="i-checks m-b-none">
					<input type="checkbox" name="ids" id="ids" value="${vo.id}" />
					<i></i></label>
					</td>
					<td>{{vo.manufcode }}</td>
					<td>{{vo.manufname }}</td>
					<td>{{vo.compscale }}</td>
					<td>{{vo.marketposition }}</td>
					<td>{{vo.regman }}</td>
					<td>{{vo.regmoney }}
					</td>
					<td>
						<a class="text-info"><i class="icon-note" onclick="editData('{{ vo.id }}','manufacturerModal');" ></i></a>
<!-- 						<a class="text-info"><i class="icon-note" ng-click="createManufacturer({{ vo.id }});" ></i></a> -->
						<a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
					</td>
				</tr>
	</tbody>
</table>